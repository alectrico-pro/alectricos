class Electrico::CampañaMailer < ApplicationMailer
  include Linea

  layout 'electrico/campaña_mailer/campaña_mailer_layout', :except => [:hello, :promo, :prueba]

  helper ::EventsHelper
  around_action :wrap_in_transaction

  default :from => Rails.configuration.domain['default_from']
  default :return_path => Rails.configuration.domain['return_path']
  default :charset => "UTF-8"


  def prueba
    mail :to => 'ventas@alectrico.cl', :subject => "Prueba de envío"
  end

  def hello(user)
    @url  = Rails.configuration.domain['name_https']
    @user = user
    user.genera_token('desuscripcion_token') if user.desuscripcion_token.nil?
    mail :to => user.email , :subject => "¿Le gustaría hacer trabajos eléctricos a domicilio en Providencia y Las Condes?".encode("UTF-8")    
  end

  def mas_info(user)
    @url  = Rails.configuration.domain['name_https']
    @user = user
    user.genera_token('desuscripcion_token') if user.desuscripcion_token.nil?
    mail :to => user.email, :subject => "Saludos #{user.nombre}"
  end

  def promo
    mail :to => "prueba@alectrico.cl", :subject => "Prueba"
  end

  #Mail dirigido a la cuenta del administrador indicando que se ha comprado un producto
  def producto_comprado(payment,orden)
    @admin = Admin.first
    @payment = payment
    @orden = orden
    mail :to => "#{@admin.email}", :subject => "Orden es #{@orden.id} pago es #{@orden.payment_id}"
  end

 #Mail dirigido al comprador
  def ud_ha_comprado(payment,orden)
    @admin = Admin.first
    @payment = payment
    @orden = orden
    mail :to => "#{@payment.payer.payer_info.email}", :subject => "Reporte de Compra: Orden es #{@orden.id} Pago es #{@orden.payment_id}"
  end

  private

  #Cambia la configuración smpt a una de google para el caso de que fallara private_email
  def wrap_in_transaction

    #Los envíos de email para campañas se hacen con mailgun y cuando ellos no quierna o no se pueda o haya error, se usará go.alectrico como fallback, en último caso se usará el valor de smtp normal 

    @campañas_smtp_settings={
      :address => 'smtp.mailgun.org',
      :authentication => 'plain',
      :port => 587,
      :domain => 'alectrico.cl',
      :user_name => 'postmaster@mg.alectrico.cl',
      :password => 'f8b38306676a88a8eba95f66f84d58eb'
    }

    @fallback_1_smtp_settings={
      :address => 'smtp.gmail.com',
      :port => 587,
      :domain => 'gmail.com',
      :authentication => 'plain',
      :user_name => 'go.alectrico@gmail.com',
      :password => 'ldmcnyptnzbnouxz',
      :enable_starttls_auto => true
    }

    @fallback_2_smtp_settings={
      :address => 'smtp.gmail.com',
      :port => 587,
      :domain => 'gmail.com',
      :authentication => 'plain',
      :user_name => 'instalaciones.alexsoft@gmail.com',
      :password => 'dzlurkepcorscfuz'
    }

    @saved_smtp_sttings = ActionMailer::Base.smtp_settings

    logger.info "Tratando de enviar email usando Electrico::CampañaMailer"



    begin
      raise "Error inventado para probar fallback" if ENV['MAILER_FALLBACK']
      ActionMailer::Base.smtp_settings= @campañas_smtp_settings
      yield

    rescue Exception => e
      ActionMailer::Base.smtp_settings= @fallback_1_smtp_settings
      begin  
        yield

      rescue Exception => e
        ActionMailer::Base.smtp_settings= @saved_smtp_sttings
        yield

        rescue Exception => e
          logger.error "No se pudo enviar email, se hicieron dos fallbacks"
      end  
    end

    ActionMailer::Base.smtp_settings= @saved_smtp_settings

  end

end
