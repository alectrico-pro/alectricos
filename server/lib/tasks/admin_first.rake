namespace :admin do
  desc "Crea el admin que asegura todo el resto"

  task first: :environment do

    Admin.create(email: "admon@alectrico.cl") do |u|
      u.email = "admon@alectrico.cl"
      u.name  = "Admon"  
      u.fono  = "962000921"
      u.admin = true
      u.password = "go.safer"
      u.save!
    end  

    Gestion::Usuario.find_or_create_by(email: Admin.first.email) do |g|
       g.activo = true
       g.email  = Admin.first.email
       g.fono   = Admin.first.fono
       if Admin.first.name
	 g.nombre = Admin.first.name
       else
	 g.nombre = g.email
       end
       g.user_id = Admin.first.id
       g.save!
       puts g.nombre
       puts g.email
    end

  end

end
