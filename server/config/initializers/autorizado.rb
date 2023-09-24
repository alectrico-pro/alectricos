COMUNAS = Autorizado.order(:comuna).distinct.pluck(:comuna).map{ |c| begin; c.downcase.to_sym; rescue; end }

