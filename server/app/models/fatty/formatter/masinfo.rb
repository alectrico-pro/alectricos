module Fatty
  class Formatter::Masinfo < Formatter
   @@texto=\
"
En la figura de arriba se muestra la ventana principal de la aplicación. Al centro está el Rosco aléctrico. En la medida que atienda clientes y estos le paguen, su ROSCO se verá más colorido.

 Si el Rosco queda pelado no le entregaremos avisos. Porque eso significará que a los clientes no les ha gustado su trabajo.

Las solicitudes de cliente se pueden tomar desde el email que reciba avisándole de ellas, desde la aplicación abierta o desde una notificación audible en su celular.

Cuando tome una solicitud desde la aplicación Ud. será su único dueño. Cuando la tome desde el email, participará con otros instaladores. Ud. decide si colaborar o no.

Cada aviso cuesta lo que se publique en https://shop.alectrico.cl como crédito de atención o recarga. El sistema de pagos es a través de Paypal y por transferencias de Khipu. Con Paypal puede comprar varias recargas en cada intento. Con Khipu solo puede comprar una cada vez. 

En la medida que sea conveniente se irán agregando otros sistemas de pago.
"

    #Son los términos de uso de alectrico.cl
    format :text do
      #Para ser usado en electrico campañas mailer mas_info
      #LLamar Fatty::Formatter::Terminos.render(:text)
      def render
	return @@texto
      end
    end

    format :html do
      def render
        "<b>Hello World</b>"
      end
    end

    format :haml do
      def render
        "%p Hello World"
      end
    end



  end
end
