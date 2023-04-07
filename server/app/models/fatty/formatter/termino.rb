module Fatty
  class Formatter::Termino < Formatter
   @@terminos=\
    "
    1. alectrico.cl es una aplicación web que permite a los instaladores eléctricos recibir avisos de nuevos trabajos eléctricos a domicilio.
    2. Los avisos son generados por personal de alectrico.cl una vez que las personas que necesitan un servicio se comunican con ellos.
    3. Excepcionalmente los propios clientes pueden generar directamente sus propios pedidos.
    4. Una vez que Ud. tenga saldo y tome un pedido del cliente, lo que tendrá será un teléfono que llamar. Eso es todo. El resto va por Ud.
    5. Ud. deberá ofrecer sus servicio a la persona que le responda el teléfono, especificando cuánto cobra.
    6. Si al cliente le parece, le dará la dirección dónde se requiere el trabajo. alectrico.cl no da ese dato por seguridad. Eso solo lo puede hacer el cliente.
    7 alectrico.cl no es un empleador ni garantiza que Ud. tenga trabajo alguno, es solo un servicio eléctrico de asesoría para los clientes y de contacto para Ud.
    8. Es importante que Ud. sea Responsable por los trabajos que haga, eso ocurre tácitamente cuando Ud. es Instalador Eléctrico Autorizado SEC.
    9. alectrico.cl usará los algoritmos que considere necesario para priorizar o descartar el envío de avisos a los Instaladores en razón del desempeño de cada uno y de la satisfacción que cada cliente demuestre.
    10. Ud. tendrá la obligación de informar de los detalles de su trabajo y de cuánto y cómo le pagó cada cliente.
    11. alectrico.cl realizará inspecciones a los trabajos realizados por los colaboradores independientes como Ud. y podrá apartarlo sin previo aviso de las listas de recibo de avisos. Eso terminará cualquier relación entre Ud. y alectrico.cl.
   "



    #Son los términos de uso de alectrico.cl
    format :text do
      #Para ser usado en electrico campañas mailer mas_info
      #LLamar Fatty::Formatter::Terminos.render(:text)
      def render
	return @@terminos
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
