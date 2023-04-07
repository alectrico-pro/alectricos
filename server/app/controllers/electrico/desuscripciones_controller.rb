module Electrico
  class DesuscripcionesController < ElectricoController 
    include Linea 

   layout 'braintree', :only => [:desuscribeme]


    def desuscribeme

      linea.debug "En desuscribeme de AutorizadosController"

      registro = ::Autorizado.find_by(:desuscripcion_token => params[:id])

      unless registro

        linea.info "Id es #{params[:id]}"

        @result  = result_hash = {
          :header => "¡Salió Todo BIEN!",
          :icon => "success",
          :message => "Actualmente Ud. no está suscrito al servicio de información de alectrico.cl. Ahora hemos anotado su email para tener en cuenta su decisión de no recibir más emails, con ello evitaremos su inclusión en nuevas campañas de marketing. No hemos querido molestarlo en su trabajo. Por favor, le ruego que nos disculpe si se ha sentido invadido."
        }

        respond_to do |format|
         format.html #{ render :suscripcion }
        end

      else
        #linea.info "Desuscribiendo #{registro.comuna} | #{registro.nombre_fantasia} "
      end
   
     repositorio = ::Repos::Autorizado

      catch :abort do
        prospecto = Electrico::Prospecto.new(registro,repositorio,self)
        linea.info "Autorizado creado"
        prospecto.desuscribete
        prospecto.guardate
      rescue Exception => e
        linea.error "Error autorizado #{e.inspect}"  
      end

    end

    def desuscripcion_exitosa autorizado
      
      linea.info "Desuscripcion exitosa de #{autorizado.nombre}"

      @autorizado = autorizado
      
      @result  = result_hash = {
        :header => "¡Salió Todo BIEN!",
        :icon => "success",
        :message => "Hemos anotado su email para no enviarle más emails desde alectrico.cl."
      }


      respond_to do |format|
        format.html { render :suscripcion }
      end

    end

    def desuscripcion_fallida autorizado

      linea.error "Desuscripcion fallida de #{autorizado.nombre}"

      @autorizado = autorizado

      @result  = result_hash = {
        :header => "¡Bah, parece que no está suscrito!",
        :icon => "success",
        :message => "Anotaremos su email para no enviarle emails desde alectrico.cl."
      }
      respond_to do |format|
        format.html { render :suscripcion }
      end
    end

  end
end
