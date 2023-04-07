namespace :integridad do
  desc "Chequeo de integridad referencial para que el cálculo eléctrico funcione bien."
  task tipo_material: :environment do
    puts "Ambiente es #{Rails.env}"
    puts "Hay  #{Electrico::Material.count} elementos Electrico::Material, no debiera haber ninguno en ambiente test porque estoy usando factories"
    Electrico::Material.all.each{|m| puts "El material #{m.nombre}, con id #{m.id} no pertenece a ningún tipo de material."}
  end
end
