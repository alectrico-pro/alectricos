namespace :genera do
  desc "genera:empalme:fact -Crea los hechos para clips a partir de la lista de empalmes"
  namespace :empalme do
    task fact: :environment do
      empalmes = D::Empalmes.new.get_nodos
       File.open("./empalmes.txt", "wb") do |fo|
	empalmes.each do |e|
	  puts e.tipo_de_empalme
          fo << "(empalme\n "
	  fo << "  (tipo-de-empalme '#{e.tipo_de_empalme}')\n"
          fo << "  (potencia-nominal #{e.potencia_nominal})\n"
          fo << "  (potencia-maxima #{e.potencia_maxima})\n"
          fo << "  (interruptor  #{ e.interruptor})\n"
	  case e.no_fases
	  when 'Trifásico'
	    fo << "  (no-fases trifasico))\n"
	  when 'Monofásico'
	    fo << "  (no-fases monofasico))\n"
	  end
          fo << "\n"
	end
      end
    end
  end
end
