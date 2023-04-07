class AutorizadosController < ApplicationController
  
  skip_before_action :verify_authenticity_token


  before_action :set_autorizado, only: [:show, :edit, :update, :destroy,:enviar_presentacion, :enviar_mas_info ]
  before_action :set_filter, only: [:index ]

  # GET /@autorizados
  # GET /@autorizados.json
  def index
    if @autorizados
      flash.notice = "#{ @autorizados.count} registros cumplen el filtro: #{@filtro} "
    else
      flash.alert = "No se han realizado búsquedas. Clique en el botón cuadrado para poder seleccionar los filtros."
    end
  end

  # GET /@autorizados/1
  # GET /@autorizados/1.json
  def show
  end

  # GET /@autorizados/new
  def new
    @autorizado = Autorizado.new
  end

 # GET /@autorizados/1/edit
  def edit
  end

 # POST /@autorizado
 # POST /@autorizado.json
  def create
    @autorizado=Autorizado.new(autorizado_params)

    respond_to do |format|
      if autorizado_params.present? and @autorizado.save
	format.html { redirect_to  @autorizado, notice: 'Autorizado se guardó con éxito.' }
	format.json { render :show, status: :created, location:  @autorizado }
      else
	format.html { render :new }
	format.json { render json: @autorizado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /@autorizados/1
  # PATCH/PUT /@autorizados/1.json
  def update
    respond_to do |format|
      if autorizado_params.present? and @autorizado.update_attributes(autorizado_params)
        format.html { redirect_to @autorizado, notice: 'Autorizado fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @autorizado }
      else
        format.html { render :edit }
        format.json { render json: @autorizado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /@autorizados/1
  # DELETE /@autorizados/1.json
  def destroy
    @autorizado.destroy
    respond_to do |format|
      format.html { redirect_to autorizados_url, notice: 'autorizado fue eliminado.' }
      format.json { head :no_content }
    end
  end

  def download_pdf
     modelo= Autorizado.find(params[:id])
     send_data generate_pdf(modelo),
         filename: "#{modelo.rut}.pdf",
             type: "aplication/pdf"
  end


  def generate_pdf(modelo)
    Prawn::Document.new do
      text "#{modelo.rut}", align: :center
      
        text " Rut:#{modelo.rut}"
      
        text " Nombre:#{modelo.nombre}"
      
        text " Direccion:#{modelo.direccion}"
      
        text " Comuna:#{modelo.comuna}"
      
        text " Fono:#{modelo.fono}"
      
        text " Clase:#{modelo.clase}"
      
        text " Email:#{modelo.email}"
      
        text " Interese:#{modelo.interese}"
      
        text " Reclutamiento:#{modelo.reclutamiento}"
      
        text " Suscripcion:#{modelo.suscripcion}"
      
        text " Presentacion:#{modelo.presentacion}"
      
    end.render
  end

  def prueba
    ::Electrico::CampañaMailer.prueba.deliver

    respond_to do |format|
      format.html do
        flash[:notice] = "Prueba Enviada"
        redirect_back(fallback_location: root_path)
      end
    end

  end

  def enviar_mas_info
    ::Electrico::CampañaMailer.mas_info(@autorizado).deliver
    @autorizado.pedido_adicional_de_informacion = :entregada_mas_informacion

    if @autorizado.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Más Info Enviada"
          redirect_back(fallback_location: root_path)
        end
      end
    end

  end

  def enviar_presentacion
    ::Electrico::CampañaMailer.hello(@autorizado).deliver
    @autorizado.presentacion = :presentada

    if @autorizado.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Presentacion Enviada"
          redirect_back(fallback_location: root_path)
        end
      end
    end
  end

  private

    def set_filter
      @filtro = nil
      Autorizado.get_filtros.each do |scope|
        if params[scope]
          @autorizados = scope.to_sym.to_proc.call( Autorizado ) 
          @filtro = scope
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_autorizado
      @autorizado = Autorizado.all.find(params[:id]) 
      #Le he agregao all porque sino arroja error de procedimiento almacenado
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def autorizado_params
      params.require(:autorizado).permit(:rut, :comentario, :nombre, :direccion, :comuna, :fono, :clase, :email, :interes, :llamadas_telefonicas, :envios_de_email, :reclutamiento, :suscripcion, :presentacion, :wapp, :nombre_completo)
    end


end
