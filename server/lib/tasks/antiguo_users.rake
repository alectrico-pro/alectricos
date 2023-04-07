namespace :antiguo_users do
  desc "Agrega usuarios a los users. Usado en la adaptación de gestión a eléctrico"

  task elimina_efimeros: :environment do
    Electrico::Presupuesto.efimero.delete_all
  end

  task crea_first_admin: :environment do

    Admin.find_or_create_by(email: "admon@alectrico.cl") do |u|
      u.email = "admon@alectrico.cl"
      u.name  = "Admon"  
      u.fono  = "962000921"
      u.password = "go.safer"
    end  

    Gestion::Usuario.find_or_create_by(email: Admin.first.email) do |g|
       g.activo = true
       g.email  = Admin.first.email
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

  task reset_presupuestos: :environment do
    Electrico::Presupuesto.all.each{|p| p.update_attributes!(:estado => :inicio)}

  end

  task usuarios: :environment do
    #Toma todos los usuarios antiguos, les crea su usuario doble en gestion usuario y prpocesa tbmién todos los clientes de presupuestos
    AntiguoUser.all.each do |u|
      Gestion::Usuario.find_or_create_by(email: u.email) do |g|
	g.activo = true
	g.email = u.mail
	if u.name
	  g.nombre = u.name
	else
	  g.nombre = g.email
	end
	g.user_id = u.id
	g.save!
	puts g.nombre
	puts g.email
      end
    end

    Electrico::Presupuesto.all.each do |p|
      if p.clientes.count > 0
        u=p.clientes.first
        if
	    p.usuario = Gestion::Usuario.find_or_create_by!(:email => u.email) do |c|
	      if u.name.blank?
	 	c.nombre = u.email
	      else
                c.nombre = u.name
	      end
	      c.email = u.email
	      c.activo = true
              c.user_id = u.id
	      c.save!
	    end
            p.save!
        end
      end
    end

  end
end
