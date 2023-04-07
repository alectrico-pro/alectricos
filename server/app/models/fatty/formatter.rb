module Fatty
  class Formatter
    #@formats = {}
    def self.formats
      @formats ||= {}
    end

    def self.format(name, options={}, &block)
      #El bloque se usa para declarar el método render, o cualquier otro método que se dsee
      formats[name] = Class.new(Fatty::Format, &block)
    end

    def self.render(format, options={})
      #El método render de esta clase se delega al método render de uno de los objetos creados y guardados en la variable de instancia de clase @formats. Cada uno de esos objetos es en realidad una clase, En ruby no importa la diferencia. Las clases pueden ser manipuladas como objetos.
      formats[format].new(options).render
      #El método new es necesario antes de llamar a render, porque render es un método de instancia. New crea una instancia de uno de los objetos de clase almacenaodos en la variable de instancia de clase @formats.
    end

  end
end
