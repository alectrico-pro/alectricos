#Modulo que ofrece un procedimiento 'procesa' para rellenar Gestion::Registro con los datos de instaladores autorizados residentes en un archivo csv
#También genera factories exactos para cada instaldor, de tal forma que se pueda generar el pdf en modo development o test
#También se setean algunas banderas para que se usen en las campañas de marketing

module Electrico::Procesa

  include Linea

  def procesa(la_clase)

    la_clase ||= 'D'

    path2archivo = './providencia.csv' #ubicado en el root de Rails

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

    File.open("autorizado_facts.txt", "#{acceso}") do |go|

      File.open("autorizado.rb","#{acceso}") do |fo|

	if Rails.env.test? #|| Rails.env.development? #Aprovechar de generar factories
	  #Factory genérica que usan factories de otros modelos
	  fo << "FactoryBot.define do \n"
	  fo << "  factory :autorizado, :class => Gestion::Registro do \n"
	  fo << "     rut              {'11.111.111-1'} \n"
	  fo << "     razon_social     {'razon_social'} \n"
	  fo << "     comuna           {'Providencia' } \n"
	  fo << "     nombre_fantasia  {'registro.nombre_fantasia'}\n"
	  fo << "     dv               {'1'}\n"
	  fo << "     direccion        {'registro.direccion'} \n"
	  fo << "     fono             {'987654321'} \n"
	  fo << "     email            {'email@alectrico.cl'} \n"
	  fo << "     comportamiento   {'Instalador Autorizado Clase D'}\n"
	  fo << "     suscripcion      { :suscrito } \n"
	  fo << "     desuscripcion_token { 'lll' } \n"
	  fo << "  end \n"
	  fo << "\n"
	end


	logger.info "Ingresando instaladores ..........."
	id = 0
	CSV.foreach(path2archivo) do |row|
	  id += 1
	  if row[licencia] == la_clase or la_clase == "*"

	    registro = Gestion::Registro.find_or_create_by(:email => row[correo]) do |r|

	      #preparando el email
	      if not row[correo].nil?
		r.email        = row[correo].downcase.strip
	      else
		r.email        = row[nombre].parameterize.underscore+'@alectrico.cl'
	      end

	      #rut sin verificar, la sec lo hizo
	      r.rut            = row[rut]


	      r.razon_social   = row[nombre].downcase.capitalize
	      r.direccion      = row[direccion].downcase.capitalize
	      r.fono           = row[telefono]

	      #Decifrando el nombre
	      resultados       = r.razon_social.downcase.match /(,)((\W\w+\W*)+)\z/
	      if resultados
		r.nombre_fantasia = resultados[2].split.map{|n| n.capitalize}.join(" ")
	      else
		r.nombre_fantasia = r.razon_social.split.map{|n| n.capitalize}.join(" ")
	      end

	      r.dv                     = row[rut].last

	      #Generando el token para proteger el :id
	      r.genera_token('desuscripcion_token')

	      #La región no es importante por ahora
	      r.region                 = ''

	      #Decifrando la comuna
	      resultados = r.direccion.downcase.match /(,)((\W\w+)+)\z/
	      if resultados
		r.comuna = resultados[2].split.map{|n| n.capitalize}.join(" ")
	      else
		resultados = r.direccion.downcase.match /(,)((\W\w+\W)+)\z/
		if resultados
		  r.comuna = resultados[2].strip.capitalize
		else
		  resultados = r.direccion.downcase.match /(,)((\w*\W*)+)\z/
		  if resultados
		     r.comuna = resultados[2].strip.capitalize
		  end
		end
	      end

	      #Participación en las campañas
	      r.comportamiento = "Instalador Autorizado Clase #{row[licencia]}"
	      r.presentacion   = :no_presentada
	      r.suscripcion    = :suscrito if r.suscripcion.nil?

	    end #find_or_create_by

	    if registro.valid? 

	      linea.info "#{registro.comuna} | #{registro.nombre_fantasia.split.map{|n| n.capitalize}.join(" ")}"
					  
	      if Rails.env.test? || Rails.env.development?
		#Esto es para las factories
		fo << "  factory :autorizado_#{id}, :class => Gestion::Registro do \n"
		fo << "     rut                 {'#{ registro.rut}'} \n"
		fo << "     razon_social        {'#{ registro.razon_social}'} \n"
		fo << "     comuna              {'#{ registro.comuna}' } \n"
		fo << "     nombre_fantasia     {'#{ registro.nombre_fantasia}'}\n"
		fo << "     dv                  {'#{ registro.dv}'}\n"
		fo << "     direccion           {'#{ registro.direccion }'} \n"
		fo << "     fono                {'#{ registro.fono }'} \n"
		fo << "     email               {'#{ registro.email}'} \n"
		fo << "     comportamiento      {'#{ registro.comportamiento}'}\n"
		fo << "     suscripcion         {:#{ registro.suscripcion.to_sym}}\n"
                fo << "     desuscripcion_token {'#{ registro.desuscripcion_token}'}\n"
		fo << "  end \n"
		fo << "\n"

		#Esto es para alectrico.expert
		go << "( registro "
		go << "( id #{registro.id } ) "
		go << "( rut '#{registro.rut}' )"
		go << "{ nombre '#{registro.nombre_fantasia}')"
		go << "{ comuna '#{registro.comuna}')"
		go << "( direccion '#{registro.direccion}' )"
		go << "( fono #{registro.fono } )"
		go << "{ comportamiento #{registro.comportamiento} )"
		go << "{ suscripcion #{registro.suscripcion} }"
		go << "( email #{registro.email}')"
		go << ")\n"

	      else

		#Solo guarda registro si no es environment test. En ese caso se usan mejor las factories
		registro.save!

	      end

	    else

	      linea.error "#{registro.comuna} | #{registro.nombre_fantasia}"
	      linea.debug registro.inspect

	    end
	  end
	end #la_clase

	fo << "end \n" if Rails.env.test? #| Rails.env.development?
	fo.close
      end
      go.close
    end

  end
end
