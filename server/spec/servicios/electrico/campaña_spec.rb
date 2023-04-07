require 'rake'
Gancho::Application.load_tasks
Autorizado.delete_all
Rake::Task['autorizado:c:prepare'].invoke if Autorizado.c.count == 0
#Autorizado.all.each{|a| a.suscripcion = :suscrito; a.save! }

RSpec.describe ::Electrico::Campaña, :type => :model do
  let! (:autorizado) { FactoryBot.create(:autorizado )}

  context "Cuando se desea programar una campaña para clase C" do
    it "Autorizado tiene instaladores de la clase C" do
      #Esto puede demorar un poco, son más de 400 instaladores, preferir la calse C para agilizar la prueba
      expect(
	Autorizado.c.count
      ).to be > 0
    end
  end

  context "Cuando la campaña es programada por scheduler en heroku" do

    it "entonces deben setearse las variables de ambiente adecuadas" do
      expect(
	ENV['AUTORIZADO_BOX_START_HOUR']
      ).not_to eq nil?
      expect(
	ENV['AUTORIZADO_BOX_END_HOUR']
      ).not_to eq nil?
      expect(
	ENV['CAMPAIGN_PARAMS']
      ).not_to eq nil?
      expect(
	JSON.parse(ENV['CAMPAIGN_PARAMS'])['limite']
      ).to be > 0
      expect(
        JSON.parse(ENV['CAMPAIGN_PARAMS'])['clase'].in? %w(A B C D)
      ).to eq true
    end

    xit "entonces la campaña debe ser llamada en el intervalo especificado" do
     #no puedo chequear eso, porque el scheduler es un add-on       
    end

    it "entonces la campaña envía la cantidad especificada" do
      expect{
        Rake::Task["autorizado:box"].invoke
      }.to change(ActionMailer::Base.deliveries, :count).by(10)
    end

    it "entonces la campaña no envía en horario no especificado" do
      ENV['AUTORIZADO_BOX_END_HOUR']   = 1.hour.ago.to_s
      expect{
        Rake::Task["autorizado:box"].invoke
      }.to change(ActionMailer::Base.deliveries, :count).by(0)
    end

    it "entonces la campaña evita enviar mensajes repetidos" do
      expect{
        Rake::Task["autorizado:box"].invoke
      }.to change(ActionMailer::Base.deliveries, :count).by(0)
    end

    it "entonces un usuario puede solicitar desuscripcion" do

      usuario = Autorizado.last
      usuario.update(:suscripcion => :suscrito, :presentacion => :presentada)
      expect( usuario.presentacion ).to eq "presentada"
      expect( usuario.suscripcion).to eq "suscrito"

      usuario.update(:suscripcion => :no_suscrito)

      #Se eliminan todos los suscritos para hacer pruebas de envio
      #con los no suscritos 
      Autorizado.suscrito.delete_all

      #A pesar de que hay usuarios autorizados, no serán contactados porque los que quedaron al borrar los suscritos, son los que no están suscritos.
      expect{
        Rake::Task["autorizado:box"].invoke
      }.to change(ActionMailer::Base.deliveries, :count).by(0)

    end

    it "no se eliminan los instaladores no_suscritos " do
      #Los registros de esos instaladores deben existir para
      #que se tenga contancia de la decisión de no recibir email
      #y que no les envíe email
      total = Autorizado.count
      Autorizado.all.each{ |a| a.suscripcion = :suscrito; a.save! }
      autorizado = Autorizado.last
      autorizado.update(:suscripcion => :no_suscrito)
      
      expect{
        Rake::Task["autorizado:*:drop"].invoke
      }.to change(Autorizado, :count).from(total).to(1)
    end

  end

  context "Cuando se usa la campaña en forma individual" do

    it "entonces puedo enviar un saludo vía email" do
      campaña = Electrico::Campaña.new(autorizado)
      expect{
        campaña.enviar_mensaje
      }.to change(::ActionMailer::Base.deliveries,:count).by(1)
    end
=begin
    it "entonces puedo enviar la lista uno a uno" do
      expect{
        Autorizado.all.each do |autorizado|
          campaña = Electrico::Campaña.new(autorizado)
          campaña.enviar_mensaje
        end
      }.to change(::ActionMailer::Base.deliveries,:count).by(Autorizado.count)
    end
=end
    it "entonces puedo enviar más de un mensaje por usuario" do
      expect{
        autorizado = Autorizado.first
        campaña = Electrico::Campaña.new(autorizado)
        campaña.enviar_mensaje
      }.to change(::ActionMailer::Base.deliveries,:count).by(1)
    end

  end
  context "Comparando dos métodos" do
    before do
      Autorizado.update(:presentacion => :no_presentada)
    end
    it "Campaña#say_hello_block" do #tiempo de ejcución?
      ::Electrico::Campaña.say_hello_block ENV['CAMPAIGN_PARAMS']
    end
    it "Campaña#say_hello" do #tiempo de ejecución ?
      ::Electrico::Campaña.say_hello ENV['CAMPAIGN_PARAMS']
    end
  end

end
