module Fatty
  class Formatter::Hello < Formatter

    #Cuano se llama a esta clase llamando usando un método de clase cualuiera, se recorre el códigi y se encuentra la línea format :text, el que es un llamado al métod de clase format, definitod n Formatter. Este método usa el argumento text la primera vez que se usa y el argumento de bloque definido en el inteiro del do. La segunda vez que se llama a format, se hace con el argumento html y el bloque interior del segundo do. El efecto de ambos es crear dos instancias de la clase FFormatter::Format con métodos de clase "render" con contenidos diferentes.
    #
    format :text do
      #Mi explicacion: esto es un bloque que es pasado como argumento al método format de la clase Formatter. El que instancía una clases Fatty::Format con el método render que compone el bloque de que hemos hblado.
      #
      def render
        "Hello World"
      end
    end

    format :html do
      def render
        "<b>Hello World</b>"
      end
    end

    format :haml do
      def render
        "%p Hello World"
      end
    end



  end
end
