#require 'rake'
#Mantiene una Chispeza Disponible

task spec: ["oferta:chispeza:diaria"]

namespace :oferta do

  namespace :chispeza do
    desc "Provisiona una Chispeza a cada Día"
  
    task diaria: :environment do
      chispeza = ::Comercio::Servicio.creditos.find_by(:nombre => "Chispeza")
      chispeza.update_attributes(:cantidad_disponible => 1) if chispeza and chispeza.cantidad_disponible < 1
    end

  end

end

