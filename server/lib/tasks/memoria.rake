#require 'rake'
#Muesta el uso de la memoria

task spec: ["memoria:*:ver"]

namespace :memoria do

  namespace :* do
    desc "Muestra toda la memoria"
  
    task ver: :environment do
      include Linea
      linea.info "Tamaño de Presupueto first"
      linea.info "#{ObjectSpace.memsize_of(Electrico::Presupuesto.first)} bytes"

      size = 0
      ObjectSpace.each_object{ |o| size += ObjectSpace.memsize_of(o) }
      linea.info "Memoria ocupada por todos los objetos"
      linea.info "#{size/1024} kbytes "
    end

  end

end

