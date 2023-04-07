#Ejecuta una campaña de marketing
#En un horario determinado
#Con las clases determindas
#Sin repetir los destinatarios
#No envíando a los no suscritos
#
#Se hace para cada usuario registrado en Gestion::Usuario, que sea autorizado
class ::Electrico::Campaña 
  extend Linea

  def initialize(user)
    @user = user
  end

  def pdf(presentacion)
    presentacion.layout
    presentacion.say_hello(@user)
    presentacion.say_direccion(@user)
    presentacion.say_detalles(@user)
    presentacion.franja
  end

  def enviar_mensaje
    catch :abort do
      ::Electrico::CampañaMailer.hello(@user).deliver
      return true
    rescue StandardError => e 
      logger.error "Método 'enviar_mensaje' de Electrico::Campaña fue abortado"
      logger.debug "{e.inspect}"
      raise "Stop"
      return false
    end
  end

  def self.say_hello_block(campaign_params_json)
    #campaign_params='{"limite":"10","clase":"D","reset":"9"}' #dejar com ENV, no usar espacios, usar las comillas como se muestra.
    campaign_params  = JSON.parse(campaign_params_json)
    el_limite        = campaign_params['limite']
    la_clase         = campaign_params['clase']
    periodo_de_reset = campaign_params['reset'].to_i
    #
    linea.info "---------------------------------------------------------"
    linea.info "Comenzando este run de la Campaña. Son #{el_limite} mensajes."
#   %w[ A B C D].each{ |clase| linea.info "Hay #{Autorizado.clase(clase).suscrito.no_presentada.count} candidatos clase #{clase} en total" }
#    %w[ A B C D].each{ |clase|  }

    linea.info "Se trabajará con la clase #{la_clase}"

    linea.info "Detalle es: .................."
    if la_clase == "*"
      linea.info "Hay #{Autorizado.count} registros en total"
      linea.info "Hay #{Autorizado.no_presentada.count} reg no presentados"
      linea.info "Hay #{Autorizado.no_suscrito.count} reg no suscritos"
      linea.info "Hay #{Autorizado.suscrito.count} reg suscritos"
    else
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).count} registros de esa clase, en total"
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).no_presentada.count} no presentadas de esa clase, en total"
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).no_suscrito.count} instaladores no suscritos de esa clase, en total"
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).suscrito.count} instaladores suscritos de esa clase, en total"
    end

    #Si se envió email a cada uno, esperar 5 días antes de resetear
    if  Autorizado.no_presentada.count > 0 \
    and Autorizado.unscope(:order).order(:updated_at).last.updated_at < periodo_de_reset.day.ago

        Autorizado.no_presentada.each do |r|
          r.update(:presentacion => :no_presentada )
        end

    end

    ( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc )
    .call( Autorizado )
    .no_presentada
    .suscrito
    .orden_clase_desc
    .limit(el_limite)
    .each_with_index do |user, index|
      ::Electrico::CampañaMailer.hello(user).deliver
      user.update( :presentacion => :presentada ) unless ENV['INTERCEPTAR']=='SI'
     end

  end




  def self.say_hello(campaign_params_json)
    #campaign_params='{"limite":"10","clase":"D","reset":"9"}' #dejar com ENV, no usar espacios, usar las comillas como se muestra.
    campaign_params  = JSON.parse(campaign_params_json)
    el_limite        = campaign_params['limite']
    la_clase         = campaign_params['clase']
    periodo_de_reset = campaign_params['reset'].to_i
    #
    linea.info "---------------------------------------------------------"
    linea.info "Comenzando este run de la Campaña. Son #{el_limite} mensajes."

#   %w[ A B C D].each{ |clase|
#linea.info "Hay #{clase.downcase.to_sym.to_proc.class(Autorizado).suscrito.no_presentada.count} candidatos clase #{clase} en total" }


    linea.info "Se trabajará con la clase #{la_clase}"

    linea.info "Detalle es: .................."
    if la_clase == "*" 
      linea.info "Hay #{Autorizado.count} registros, en total"
      linea.info "Hay #{Autorizado.no_presentada.count} reg no presentados"
      linea.info "Hay #{Autorizado.no_suscrito.count} reg no suscritos"
      linea.info "Hay #{Autorizado.suscrito.count} reg suscritos"
    else
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).count} registros de esa clase, en total"
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).no_presentada.count} no presentadas de esa clase, en total"
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).no_suscrito.count} instaladores no suscritos de esa clase, en total"
      linea.info "Hay #{( la_clase == "*" ? nil.to_proc : la_clase.downcase.to_sym.to_proc ).call( Autorizado ).suscrito.count} instaladores suscritos de esa clase, en total"
    end
    #Si se envió email a cada uno, esperar 5 días antes de resetear
    if  Autorizado.no_presentada.count > 0 \
    and Autorizado.unscope(:order).order(:updated_at).last.updated_at < periodo_de_reset.day.ago

	Autorizado.no_presentada.each do |r|
	  r.update(:presentacion => :no_presentada )
	end

    end

    #bloque de la campaña, necesita especificaciones en run_campaign (abajo)
    self.run_campaign(la_clase,el_limite) do |user, index|
      linea.info(
      "#{index + 1} - id: #{user.id} - email #{user.email}, a #{user.nombre} - clase #{user.clase}" )
      if user.email
        ::Electrico::CampañaMailer.hello(user).deliver
      else
        linea.info( "El user no tenía email por eso no se envió el mensaje" )
      end
      user.update(:presentacion => :presentada ) unless ENV['INTERCEPTAR']=='SI'
    end


  end

  #corre la campaña en block, para las variantes de clase y limite
  def self.run_campaign(clase, limite, &block)
    linea.info ".............................."

    #si la clase es * se usa el scope 'autorizado_todos', sino se usa un scope evaluado 'autorizado' con argumento 'clase'.
    #Note que el procesamiento se cede a un bloque que debe haber sido ingresado como argumento de run_campaign
    clase == "*" \
       ? Autorizado.no_presentada.suscrito.orden_clase_desc.limit(limite).each_with_index{ |user,index| yield(user,index) } \
       : clase.downcase.to_sym.to_proc.call( Autorizado ).no_presentada.suscrito.orden_clase_desc.limit(limite).each_with_index{ |user,index| yield(user,index) }
    linea.info "Término de este run de la Campaña ---------------------."

  end
end
