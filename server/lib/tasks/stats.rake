#require 'rake'
#Envía tablas de la base de datos de produccción a la de estadísticas
#STATS

task spec: ["stats:preguntas:enviar"]

namespace :stats do
  desc "Estadísticas STATS"

  namespace :preguntas do
    task enviar: :environment do
      include Linea

#      box_start_at = ENV['ENVIO_DE_RENDICION_DIARIA_START_HOUR'].to_i
 #     box_end_at   = ENV['ENVIO_DE_RENDICION_DIARIA_END_HOUR'].to_i
 #    hora_actual  = Time.now.in_time_zone.strftime("%H").to_i

  #    linea.info "rake rendicion_diaria:enviar"
   #   linea.info "Hora de comienzo es a las #{box_start_at} horas"
   #   linea.info "Hora de finalización es a las #{box_end_at} horas"
    #  linea.info "Hay #{Colaborador.activo.count} candidatos"

     # if (hora_actual >= box_start_at and hora_actual <= box_end_at ) || Rails.env.test?
      #  linea.info "Es hora de enviar rendiciones"
       # linea.info "LLamando a campaña.say_rendicion_diaria, a las #{Time.now.in_time_zone} horas"
       # linea.info "Parámetros de campaña #{ENV['RENDICION_DIARIA_JSON_PARAMS']}"
        ::Resguardo::Enviar.tabla(Pregunta)
     # else
      #  linea.error "No es hora de enviar rendiciones diarias"
     # end
    end
  end
end



