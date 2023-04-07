namespace :instalador do
  desc "Crea el instalador que permite crear presupuestos"

  task first: :environment do

    Ingeniero.create(email: "ingeniero@alectrico.cl") do |u|
      u.email = "ingeniero@alectrico.cl"
      u.name  = "Ingeniero"  
      u.ingeniero = true
      u.fono  = "962000921"
      u.password = "go.safer"
      u.save!
    end  

    Gestion::Usuario.find_or_create_by(email: Ingeniero.first.email) do |g|
       g.activo = true
       g.email  = Ingeniero.first.email
       g.fono   = Ingeniero.first.fono
       if Ingeniero.first.name
	 g.nombre = Ingeniero.first.name
       else
	 g.nombre = g.email
       end
       g.user_id = Ingeniero.first.id
       g.save!
       if g.save
	 puts "Se creó exitosamente el ingeniero"
         puts g.nombre
         puts g.email
       else
	 puts "No pudo ser creado el ingeniero"
       end

    end

  end

end
