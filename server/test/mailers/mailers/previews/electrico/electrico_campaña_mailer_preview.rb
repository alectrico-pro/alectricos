# Preview all emails at http://localhost:3000/rails/mailers/custom_mailer
class ::Electrico::CampañaMailerPreview < ActionMailer::Preview

  def hello_preview
    ::Electrico::CampañaMailer.hello(Autorizado.first)
  end

  def mas_info_preview
    ::Electrico::CampañaMailer.mas_info(Autorizado.first)
  end

  def promo_preview
    ::Electrico::CampañaMailer.promo
  end

=begin
  def producto_comprado_preview

    orden=FactoryBot.create(:orden, :items_count => 2)
    #FactoryBot.creat(:orden, :items_count => 2) no actualiza amount.total ni 
    #En vez de llamar a otro FactoryBot que cree imágenes de los servicios
    #Busco un servicio que ya tanga imágenes
    orden.payment.transactions.first.item_list.items.each do |item|
      item.sku = ::Comercio::Servicio.where('tempfile is not null').first
    end
    total = orden.payment.transactions.first.item_list.items.each.sum(&:price)
    orden.payment.transactions.first.amount.total = total
    ::Comercio::UserMailer.producto_comprado( orden.payment, orden )

  end

  def ud_ha_comprado_preview
    orden=FactoryBot.create(:orden, :items_count => 2)

    orden.payment.transactions.first.item_list.items.each do |item|
      item.sku = ::Comercio::Servicio.where('tempfile is not null').first
    end
    total = orden.payment.transactions.first.item_list.items.each.sum(&:price)
    orden.payment.transactions.first.amount.total = total
    ::Comercio::UserMailer.ud_ha_comprado( orden.payment, orden )
  end
=end

end
