namespace :profesor do
  desc "Crea el profesor  que permite crear checklists"

  task first: :environment do

    Profesor.create(email: "profesor@alectrico.cl") do |u|
      u.email = "profesor@alectrico.cl"
      u.name  = "Profesor"  
      u.profesor = true
      u.fono  = "962000921"
      u.password = "go.safer"
      u.save!
    end  

    Gestion::Usuario.find_or_create_by(email: Profesor.first.email) do |g|
       g.activo = true
       g.email  = Profesor.first.email
       g.fono   = Profesor.first.fono
       if Profesor.first.name
	 g.nombre = Profesor.first.name
       else
	 g.nombre = g.email
       end
       g.user_id = Profesor.first.id
       g.save!
       if g.save
	 puts "Se creó exitosamente el profesor"
         puts g.nombre
         puts g.email
       else
	 puts "No pudo ser creado el profesor"
       end

    end

  end

end
