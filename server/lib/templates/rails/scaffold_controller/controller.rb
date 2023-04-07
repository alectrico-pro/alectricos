<% @namespace_= capture do %><% if not class_name.empty? %><%=class_name.to_s.deconstantize.downcase%><%end%><%end%>
<% @namespace = capture do %><% if not class_name.empty? %><%=class_name.to_s.deconstantize.downcase %><%end%><%end%>
<% @var = capture do %>@<%=@namespace_%><%=plural_name.singularize%><%end%>
<% @constante = capture do %><%=class_name %><%end%>
<% @value = capture do %><%=@namespace_%><%=plural_name.singularize%><%end%>
<% @vars = capture do %>@<%=@namespace_%><%=plural_name%><%end%>
#Este controlador fue generado por un template ubicado en lib/templates/rails/scaffold_controller/controller.rb
class <%= class_name.pluralize %>Controller < <%=@namespace ? @namespace.capitalize : 'Application:'%>Controller

 http_basic_authenticate_with name: "gope", password: "crisis"# except: [:index, :show]
  before_action :admin_user!
  before_action :set_<%=@value%>, only: [:show, :edit, :update, :destroy]

  # GET /<%=@vars%>
  # GET /<%=@vars%>.json
  def index
    <%=@vars%>= <%= @constante%>.all
  end

  # GET /<%=@vars%>/1
  # GET /<%=@vars%>/1.json
  def show
  end

  # GET /<%=@vars%>/new
  def new
    <%=@var%> = <%=@constante%>.new
  end

 # GET /<%=@vars%>/1/edit
  def edit
  end

 # POST /<%=@var%>
 # POST /<%=@var%>.json
  def create
    <%=@var%>=<%=@constante%>.new(<%=@value%>_params)

    respond_to do |format|
      if <%=@value%>_params.present? and <%=@var%>.save
	format.html { redirect_to  <%=@var%>, notice: '<%=@value.capitalize%> se guardó con éxito.' }
	format.json { render :show, status: :created, location:  <%=@var%> }
      else
	format.html { render :new }
	format.json { render json: <%=@var%>.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /<%=@vars%>/1
  # PATCH/PUT /<%=@vars%>/1.json
  def update
    respond_to do |format|
      if <%=@value%>_params.present? and <%=@var%>.update_attributes(<%=@value%>_params)
        format.html { redirect_to <%=@var%>, notice: '<%=@value.capitalize%> fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: <%=@var%> }
      else
        format.html { render :edit }
        format.json { render json: <%=@var%>.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /<%=@vars%>/1
  # DELETE /<%=@vars%>/1.json
  def destroy
    <%=@var%>.destroy
    respond_to do |format|
      format.html { redirect_to <%=@value.pluralize%>_url, notice: '<%=@value%> fue eliminado.' }
      format.json { head :no_content }
    end
  end

  def download_pdf
     modelo= <%= @constante%>.find(params[:id])
     send_data generate_pdf(modelo),
         filename: "#{modelo.<%=@attributes.each.first.name%>}.pdf",
             type: "aplication/pdf"
  end


  def generate_pdf(modelo)
    Prawn::Document.new do
      text "#{modelo.<%=@attributes.each.first.name%>}", align: :center
      <%@attributes.each do |a| %>
        text " <%=a.name.capitalize%>:#{modelo.<%=a.name%>}"
      <%end%>
    end.render
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= @value %>
      <%=@var%> =<%= @constante%>.all.find(params[:id]) 
      #Le he agregao all porque sino arroja error de procedimiento almacenado
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def <%=@value%>_params
      params.require(:<%=@value%>).permit(<% @attributes.each do |a| %>:<%= a.name %>, <%end%>)
    end

end
