#Modulo que ofrece un procedimiento 'procesa' para rellenar Autorizado con los datos de instaladores autorizados residentes en un archivo csv
#También genera factories exactos para cada instaldor, de tal forma que se pueda generar el pdf en modo development o test
#También se setean algunas banderas para que se usen en las campañas de marketing
require 'csv'
module Prospecto::Procesa
  include Linea

  def procesa( la_clase )

    clase = la_clase

    clase ||= 'D'

    facts_path = Rails.root.join('app', 'servicios', 'prospecto', 'autorizado_facts.txt')
    rb_path = Rails.root.join('autorizado.rb')
    path2archivo = Rails.root.join('app','servicios', 'prospecto','providencia.csv') 

    #Número de columna en el archivo csv
    nombre    = 0 #texto separado por coma, Ultima coma es nombre
    correo    = 1 #in20
    rut       = 2 #char 9
    direccion = 3 #texto 200 ultima coma es comuna
    telefono  = 4 #texto 9
    celular   = 5 #texto 9
    licencia  = 6 #texto 10

    #Durante test y development se aprovecha de crear archivos.
    #En heroku no se pueden crear archivos, por eso se cambia el método de acceso
    acceso =  ( Rails.env.test? || Rails.env.development? ) ? \
             "wb" : "r"

    File.open(facts_path, "#{acceso}") do |go|

      File.open(rb_path,"#{acceso}") do |fo|

	if Rails.env.test? || Rails.env.development?
	  #Factory genérica que usan factories de otros modelos
	  fo << "FactoryBot.define do \n"
	  fo << "  factory :autorizado, :class => Autorizado do \n"
          fo << "     nombre           {'nombre' } \n"
	  fo << "     rut              {'11.111.111-1'} \n"
          fo << "     clase            {'d'}\n"
	  fo << "     comuna           {'Providencia' } \n"
	  fo << "     direccion        {'registro.direccion'} \n"
	  fo << "     fono             {'987654321'} \n"
	  fo << "     email            {'email@alectrico.cl'} \n"
	  fo << "     suscripcion      { :suscrito } \n"
	  fo << "     desuscripcion_token { 'lll' } \n"
	  fo << "  end \n"
	  fo << "\n"
	end

	logger.info "Ingresando instaladores ..........."

        rows = CSV.read(path2archivo)

        filas = Enumerator.new do |y|
          rows.each.with_index do |x, idx|
            y << x unless idx == 0
          end
        end

        #rows = nil #recordar limpiar memoria
	id = 0
	filas.each do |row|
	  id += 1
	  if row[licencia] == la_clase or la_clase == "*"
            r= Autorizado.find_or_create_by(:rut => row[rut])
	   #registro = Autorizado.find_by(:rut => row[rut]) do |r|
	      #preparando el email
              r.email          = row[correo] ? row[correo].downcase.strip : nil
              r.envios_de_email= row[correo] ? nil : :sin_email
              r.envios_de_email= :problemas_con_email unless r.comentario.nil?
	      r.rut            = row[rut]
              r.clase          = row[licencia].downcase.to_sym
	      el_nombre        = row[nombre].downcase.capitalize

	      r.direccion      = row[direccion].downcase.capitalize
              r.fono           = row[telefono]
	      r.llamadas_telefonicas = row[telefono] ? nil : :sin_fono

	      #Decifrando el nombre
	      resultados       = el_nombre.match /(,)((\W\w+\W*)+)\z/
	      if resultados
		r.nombre = resultados[2].split.map(&:capitalize).join(" ")
	      else
		r.nombre = el_nombre.split.map(&:capitalize).join(" ")
	      end
              r.nombre_completo = r.nombre + " "  + (/^(\p{L}*\s*\p{L}*\s*)/.match( el_nombre )[1]).split.map(&:capitalize).join(" ")

	      #Generando el token para proteger el :id
	      r.genera_token('desuscripcion_token')

	      #Descifrando la comuna
	      r.comuna = (/(\p{L}*\s*\p{L}*\s*)\z/.match( r.direccion )[1]).strip.capitalize

	      #Participación en las campañas
	      r.presentacion   = :no_presentada if r.presentacion.nil?
	      r.suscripcion    = :suscrito if r.suscripcion.nil?
              r.reclutamiento  = :no_reclutado if r.reclutamiento.nil?
              r.pedido_adicional_de_informacion = :no_entregada_mas_informacion if r.pedido_adicional_de_informacion.nil?

	   #end #find_or_create_by
   
            registro = r

	    if registro.valid? 
              registro.save!
            
	      linea.info "#{registro.comuna} | #{registro.nombre.split.map{|n| n.capitalize}.join(" ")}"
	      linea.info "#{registro.id} | #{registro.nombre_completo}"				  
   
	      if false and Rails.env.test? || Rails.env.development?
		#Esto es para las factories
		fo << "  factory :autorizado_#{id}, :class => Autorizado do \n"
                fo << "     nombre              {'#{ registro.nombre}'} \n"
		fo << "     rut                 {'#{ registro.rut}'} \n"
                fo << "     clase               {'#{ registro.clase}'}\n"
		fo << "     comuna              {'#{ registro.comuna}' } \n"
		fo << "     direccion           {'#{ registro.direccion }'} \n"
		fo << "     fono                {'#{ registro.fono }'} \n"
		fo << "     email               {'#{ registro.email ? registro.email : "autorizado_#{id}@alectrico.cl" }'} \n"
                fo << "     desuscripcion_token {'#{ registro.desuscripcion_token}'}\n"
		fo << "  end \n"
		fo << "\n"

		#Esto es para alectrico.expert
		go << "( registro "
		go << "( id #{registro.id } ) "
                go << "( nombre #{registro.nombre})"
		go << "( rut '#{registro.rut}' )"
                go << "( clase '#{registro.clase}' )"
		go << "{ comuna '#{registro.comuna}')"
		go << "( direccion '#{registro.direccion}' )"
		go << "( fono #{registro.fono } )"
		go << "{ suscripcion #{registro.suscripcion} }"
		go << "( email #{registro.email}')"
		go << ")\n"

	      else

		#Solo guarda registro si no es environment test. En ese caso se usan mejor las factories
		registro.save!

	      end

	    else

	      linea.error "#{registro.comuna} | #{registro.nombre}"
              linea.error "#{registro.errors.inspect}"
	      linea.debug registro.inspect

	    end
	  end
	end #la_clase

	fo << "end \n" if Rails.env.test? || Rails.env.development?
	fo.close
      end
      go.close
    end

  end
end
