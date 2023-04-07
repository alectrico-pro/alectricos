#require 'rake'
#Guarda los instaladores en Autorizado

#Ejemplo de uso, preparar el email que se quiere enviar
#buscarlo en app/views/electrico/campaña_mailer/hello.html.haml
#Luego rake autorizado:*:no_presentada
#Confirugar los datos de la campaña
#el limite es la cantidad de envíos cada vez que schedule llama, eso puede ser cada 10 minutos
#La clase es la clase de instalador  a la que se quiere enviar la campaña. Va dsde A hasta D. Reset es la cantidad de días que se espera para reenviar la campaña
#CAMPAIGN_PARAMS
#{"limite":"10","clase":"*","reset":"7"}

#Luego rake autorizado:*:no_presentada
#Colocar Interceptar en SI para probar
#No olvidar setear las horas de la cmapaña con BOX_sTART_
#   box_start_at = ENV['AUTORIZADO_BOX_START_HOUR'].to_i
#   box_end_at   = ENV['AUTORIZADO_BOX_END_HOUR'].to_i



task spec: ["autorizado:box"]

task spec: ["autorizado:*:prepare"]
task spec: ["autorizado:*:drop"]
task spec: ["autorizado:*:no_presentada"]

task spec: ["autorizado:a:prepare"]
task spec: ["autorizado:a:drop"]

task spec: ["autorizado:b:prepare"]
task spec: ["autorizado:b:drop"]

task spec: ["autorizado:c:prepare"]
task spec: ["autorizado:c:drop"]

task spec: ["autorizado:d:prepare"]
task spec: ["autorizado:d:drop"]

task spec: ["autorizado:d:centro:pdf"]


namespace :autorizado do
  desc "MailBox de Campaña Autorizado"

  task box: :environment do
    include Linea

    box_start_at = ENV['AUTORIZADO_BOX_START_HOUR'].to_i
    box_end_at   = ENV['AUTORIZADO_BOX_END_HOUR'].to_i
    hora_actual   = Time.now.in_time_zone.strftime("%H").to_i

    linea.info "rake autorizado:box enviando"
    linea.info "Hora de comienzo es a las #{box_start_at} horas"
    linea.info "Hora de finalización es a las #{box_end_at} horas"
    linea.info "Hay #{Autorizado.count} candidatos"

    if (hora_actual >= box_start_at and hora_actual <= box_end_at ) || Rails.env.test?

      linea.info "Es hora de trabajar"
      linea.info "LLamando a campaña.say_hello, a las #{hora_actual} horas"
      linea.info "Parámetros de campaña #{ENV['CAMPAIGN_PARAMS']}"
      ::Electrico::Campaña.say_hello(ENV['CAMPAIGN_PARAMS'])
    else
      linea.error "No es hora de trabajar"

    end

  end

end

namespace :autorizado do
  desc "Genera Pdf con todos los instaladores de Providencia Las Condes y Ñuñoa"
  namespace :d do
    namespace :centro do
      task pdf: :environment do

	presentacion = Prawn::Presentacion.new( "registro" )
	%w[A B C D].each do |la_clase|
	  ["Providencia", "Las Condes","Nunoa"].each do |la_comuna|
	     :comuna.to_proc.call( ::Autorizado, la_comuna )
	     .autorizado( la_clase )
	     .each do |autorizado|
	       presentacion.layout
	       presentacion.say_hello( autorizado )
	       presentacion.say_direccion( autorizado )
               presentacion.say_historial( autorizado )
	       presentacion.say_detalles( autorizado )
	       presentacion.franja
	       presentacion.start_new_page
	    end
          end
	end
	presentacion.save_as("autorizados_centro.pdf")

      end
    end
  end
end

namespace :autorizado do
  desc "Saluda Instaladores de Campaña"

  task say_hello: :environment do
    ::Electrico::Campaña.say_hello(ENV['CAMPAIGN_PARAMS'])
  end
end

namespace :autorizado do
  desc "Ingrea Instaladores A,B,C,D"

  namespace :* do
    task prepare: :environment do
      include Prospecto::Procesa

      procesa('*')
    end
  end
end

namespace :autorizado do
  desc "Elimina Instaladores A,B,C,D"

  namespace :* do
    task drop: :environment do
      desc "Elimina todos los instaladores autorizados del modelo Autorizado"
      Autorizado.suscrito.delete_all
    end
  end

  namespace :* do
    task no_presentada: :environment do
      desc "Modifica la bandera presentación para indicar que no ha sido presentado para todos los autorizados del modelo Gestion::Registro"
      Autorizado.all.each{|p| p.update_attributes(:presentacion => :no_presentada )}
    end
  end



end

namespace :autorizado do
  desc "Ingresa Instaladores A"

  namespace :a do
    task prepare: :environment do
      include Prospecto::Procesa

      desc "Crea los destinatarios instaladores eléctricos autorizados clase A para una campaña de instaladadores autorizados"
      procesa('A')
    end
  end

end

namespace :autorizado do
  desc "Elimina Instaladores A"

  namespace :a do
    task drop: :environment do
      Autorizado.clase('A').suscrito.delete_all
    end
  end

end

namespace :autorizado do
  desc "Ingresa Instaladores  B"

  namespace :b do
    task prepare: :environment do
      include Prospecto::Procesa

      procesa('B')
    end
  end
end

namespace :autorizado do
  desc "Elimina Instaladores B"

  namespace :b do
    task drop: :environment do
      desc "Elimina los instaldores autorizados clase B"
      Autorizado.clase('B').suscrito.delete_all
    end
  end
end

namespace :autorizado do
  desc "Ingresa Instaladores C"

  namespace :c do
    task prepare: :environment do
      include Prospecto::Procesa

      procesa('C')
    end
  end
end

namespace :autorizado do
  desc "Elimina Instaladores C"

  namespace :c do
    task drop: :environment do
      Autorizado.clase('C').suscrito.delete_all
    end
  end
end

namespace :autorizado do
  namespace :d do
    task prepare: :environment do 
      include Prospecto::Procesa
      desc "Ingresa Instaladores D"
      procesa('D')
    end
  end
end

namespace :autorizado do
  desc "Elimina Instaladores D"

  namespace :d do 
    task drop: :environment do
      Autorizado.clase('D').suscrito.delete_all
    end
  end
end

