module Electrico 

  #Maneja el modelo (no ActiveRecord) Autorizado, el que representa 
  #a un Instalador Autorizado que aún no está inscrito en alectrico

  #El contenido de este modelo se origina en un archivo csv

  #El soporte de datos que se usa es el de Gestion::Registro

  #Debe iniciarse el repositorio de Electrico::AutorizadoRepositorio 
  #Se hace de esta forma para agilizar y facilitar las pruebas 

  #Se puede hacer pruebas de la lógica sin redireccionar para ningú lado 
  #Ni cargar las dependencias de Rails ni otros ¡Es es ser Hexagonal!
  class Prospecto

    include Linea

    attr_reader :nombre
    attr_reader :email
    attr_reader :direccion
    attr_reader :clase
    attr_reader :fono
    attr_reader :repositorio


    def initialize(user,el_repositorio,el_puerto)
      throw :abort unless user and el_repositorio and el_puerto
      @puerto      = el_puerto
      @repositorio = el_repositorio
      @nombre      = user.nombre_fantasia
      @email       = user.email    
      @fono        = user.fono
      @clase       = user.comportamiento
      @direccion   = user.direccion
      @user        = user
      linea.info "#{@nombre} inicializado como Electrico::Autorizado"
      return self
    end

    def desuscribete
      resultado = @repositorio.actualiza(@user, :suscripcion => :no_suscrito)
      redireccionar self, resultado
      resultado ? linea.info( "#{@nombre} se desuscribió de la campaña") : linea.error("#{@nombre} no se pudo desuscribir de la campaña")
    end

    def guardate
      res = @repositorio.guarda(@user)
      res ? linea.info( "#{@nombre} se guardó exitosamente") : linea.error( "#{@nombre} no se pudo guardar")
    end

    def es_valido
      @repositorio.es_valido?(@user)
    end

   def redireccionar autorizado, resultado
      if resultado
        logger.info "Desuscripción exitosa."
        @puerto.desuscripcion_exitosa autorizado
      else
        logger.warn "Desuscripción fallida."
        @puerto.desuscripcion_fallida autorizado
      end
    end

  end

end

