#require 'rake'
#Envía Rendiciones Diarias a los Colaboradores Activos

task spec: ["rendicion:diaria:enviar"]
task spec: ["rendicion:mensual:enviar"]
task spec: ["rendicion:resguardar"]
task spec: ["rendicion:usuario:resguardar"]
task spec: ["rendicion:corriente:enviar"]

namespace :rendicion do

  desc "MailBox de Rendición Diaria"

  task resguardar: :environment do
    ::Resguardo::EnviarModelo.new('Operacion::Rendicion')
  end

  namespace :usuario do
    desc "Guardando Gestion::Usuario"
  
    task resguardar: :environment do
      ::Resguardo::EnviarModelo.new('Gestion::Usuario')
    end

  end

  namespace :diaria do
    desc "MailBox de Rendición Diaria"

    task enviar: :environment do
      include Linea

      linea.info "Hay #{Colaborador.activo.count} candidatos"
      linea.info "Es hora de enviar rendiciones"
      linea.info "LLamando a campaña.say_rendicion_diaria, a las #{Time.now.in_time_zone} horas"
      linea.info "Parámetros de campaña #{ENV['RENDICION_DIARIA_JSON_PARAMS']}"
      ::Operacion::EnviarRendicion.say_rendicion_diaria(ENV['RENDICION_DIARIA_JSON_PARAMS'])
    end

  end

  namespace :mensual do
    desc "MailBox de Rendición Mensual"

    task enviar: :environment do
      include Linea

      linea.info "rake rendicion_mensual:enviar"
      linea.info "Hay #{Colaborador.activo.count} candidatos"
      linea.info "LLamando a campaña.say_rendicion_mensual, a las #{Time.now.in_time_zone} horas"
      linea.info "Parámetros de campaña #{ENV['RENDICION_MENSUAL_JSON_PARAMS']}"
      ::Operacion::EnviarRendicion.say_rendicion_mensual(ENV['RENDICION_MENSUAL_JSON_PARAMS'])
    end

  end

  namespace :corriente do
    desc "MailBox de Rendiciones Diarias y Mensual, corrientes"

    task enviar: :environment do
      include Linea

      linea.info "rake rendicion:mensual:corriente"

      linea.info "Hay #{Colaborador.activo.count} candidatos"
      linea.info "LLamando a campaña.say_rendicion_mensual, a las #{Time.now.in_time_zone} horas"
      linea.info "Parámetros de campaña #{ENV['RENDICION_MENSUAL_JSON_PARAMS']}"
      ::Operacion::EnviarRendicion.say_rendicion_mensual_corriente(ENV['RENDICION_MENSUAL_JSON_PARAMS'])

      linea.info "Hay #{Colaborador.activo.count} candidatos"
      linea.info "LLamando a campaña.say_rendicion_diaria, a las #{Time.now.in_time_zone} horas"
      linea.info "Parámetros de campaña #{ENV['RENDICION_MENSUAL_JSON_PARAMS']}"
      ::Operacion::EnviarRendicion.say_rendicion_diaria_corriente(ENV['RENDICION_DIARIA_JSON_PARAMS'])


    end

  end



end

