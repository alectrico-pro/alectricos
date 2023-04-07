desc "Pings PING_URL to keep a dyno alive"
task :dyno_ping do
  include Linea
  require "net/http"

  if ENV['PING_URL']
    uri = URI(ENV['PING_URL'])
    if ENV['PING_START_HOUR_AT'] and ENV['PING_END_HOUR_AT']
      ping_start_at = ENV['PING_START_HOUR_AT'].to_i  
      ping_end_at   = ENV['PING_END_HOUR_AT'].to_i
      hora_actual   = Time.now.strftime("%H").to_i
      if hora_actual > ping_start_at and hora_actual < ping_end_at
  #      linea.info "Hay límite de horario para los ping"
#	linea.info "Hora de comienzo es a las #{ping_start_at} horas"
#	linea.info "Hora de finalización es a las #{ping_end_at} horas"
#	linea.info "Fue enviado un ping a #{uri}, a las #{hora_actual} horas"
	Net::HTTP.get_response(uri)
      end
    else
  #    Net::HTTP.get_response(uri)
#      linea.info "No hay límite de horario para los ping"
 #     linea.info "Fue enviado un ping a #{uri}, a las #{hora_actual} horas"
    end
  end
end


#heroku config:add PING_URL=https://www.alectrico.cl --app alectrico
#$ heroku addons:add scheduler:standard --app alectrico
#$ heroku addons:open scheduler -app alectrico
#$ rake dyno_ping
