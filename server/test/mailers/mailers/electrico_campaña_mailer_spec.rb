require 'rails_helper'

RSpec.describe ::Electrico::CampañaMailer, type: :mailer do
  let (:autorizado) { ::FactoryBot.create( :autorizado ) }

  context "#hello" do
    let (:hello_mail) { ::Electrico::CampañaMailer.hello(autorizado) }

    it 'render headers' do
      expect( hello_mail.from).to eq(["ventas@alectrico.cl"])
      expect( hello_mail.to).to	eq([autorizado.email])
      expect( hello_mail.subject).to eq("¿Le gustaría hacer trabajos eléctricos a domicilio en Providencia y Las Condes?")
    end

    it 'render body' do
      expect( hello_mail.body.encoded.match( /Visitas a Domicilio en La Ciudad/ ))
    end

  end

  context "#mas_info" do
    let (:mas_info_mail) { ::Electrico::CampañaMailer.mas_info(autorizado) }

    it 'render headers' do
      expect( mas_info_mail.from).to eq(["ventas@alectrico.cl"])
      expect( mas_info_mail.to).to eq([autorizado.email])
      expect( mas_info_mail.subject).to eq("Saludos #{autorizado.nombre}")
    end

    it 'render body' do
      expect( mas_info_mail.body.encoded.match( /Más Información/ ))
    end

  end

end
