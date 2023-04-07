namespace :instalador do
  desc "Crea el instalador que permite crear presupuestos"

  task first: :environment do

    Instalador.create(email: "instalador@alectrico.cl") do |u|
      u.email = "instalador@alectrico.cl"
      u.name  = "Instalador"  
      u.fono  = "962000921"
      u.instalador = true
      u.password = "go.safer"
      u.save!
    end  

    Gestion::Usuario.find_or_create_by(email: Instalador.first.email) do |g|
       g.activo = true
       g.email  = Instalador.first.email
       g.fono   = Instalador.first.fono
       if Instalador.first.name
	 g.nombre = Instalador.first.name
       else
	 g.nombre = g.email
       end
       g.user_id = Instalador.first.id
       g.save!
       puts g.nombre
       puts g.email
    end

  end

end
