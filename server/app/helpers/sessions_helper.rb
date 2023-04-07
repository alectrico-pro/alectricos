#encoding: UTF-8
module ::SessionsHelper
  include Linea

  def variantiza
    request.variant = :trastienda
  end

end
