namespace :genera do
  desc "Crea la tabla de tipo de circuitos"

  task tipo_circuito: :environment do

    Electrico::TipoCircuito.delete_all
    id           = [1 ,2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,15]
    letras       = %w[D I  N  F  C  A  X R  L  S   H  M  G  Z  E]
    capacidad =    [16,10,16,16,20,20,16,10,16,16, 16,20,16,16,32]



    requiere_diferencial = [true , 
			    false, 
			    true , 
			    true , 
			    true , 
			    true ,
			    true ,
			    true ,
			    true ,
			    true , 
			    true ,
			    true ,
                            true ,
                            true ,
			    true   ]
   nombre= [
	    "Dormitorio",
	    "Iluminación",
	    "Enchufes Normales", 
	    "Enchufes Libres" , 
	    "Calefacción" , 
	    "Aire Acondicionado",
	    "Alimentador",
	    "Refrigerador", 
	    "Exclusivo Loggia",
	    "Salas",
	    "Exclusivo Horno",
	    "Mesón",
	    "Legrand",
	    "Exclusivo Lavavajillas",
	    "Exclusivo Encimeras"
   ]
    id.each_with_index do |id , index|
      Electrico::TipoCircuito.create do |u|
	puts "-----------------------------------"
	u.id                   = id
	u.nombre               = nombre[index]
	u.requiere_diferencial = requiere_diferencial[index]
	u.letras               = letras[index]
	u.capacidad            = capacidad[index]
	puts "#{u.id} Tipo de Circuito #{u.letras} #{u.nombre} #{u.capacidad*220}"
      end
    end
    puts "Hay #{Electrico::TipoCircuito.count} tipo de circuitos"
  end
end
