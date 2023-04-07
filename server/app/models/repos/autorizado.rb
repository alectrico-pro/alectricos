module Repos
  module Autorizado 
    extend self
    def guarda(user)
      user.save
    end
    def actualiza( user, campos )
      user.update_attributes(campos)
    end
    def es_valido( user )
      user.valid?
    end
  end
end
