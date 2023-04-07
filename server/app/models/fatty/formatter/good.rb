module Fatty
  class Formatter::Good < Formatter

    #Cuando se llama a esta clase,usando un método de clase cualuiera, se recorre el código y se encuentra la línea format :text, el que es un llamado al métodode clase format, definido en Formatter (el ancestro de esta clase). Este método usa el argumento text la primera vez que se usa y el argumento de bloque definido en el interior del do. La segunda vez que se llama a format, se hace con el argumento html y el bloque interior del segundo do. El efecto de ambos es crear dos instancias de la clase Formatter::Format con métodos de clase "render" con contenidos diferentes.
    #
    format :text do
      #Mi explicacion: esto es un bloque que es pasado como argumento al método format de la clase Formatter. El que es una instanciaa de clase Fatty::Format con el método render que compone el bloque de que hemos hblado.
      #
      def render
        "Good By World"
      end
    end

    format :html do
      def render
        "<b>Good By World</b>"
      end
    end

  end
end
