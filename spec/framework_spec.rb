require 'rspec'
require_relative '../src/framework'

describe 'framework tests' do

  it 'dice mi pertenencia' do
    una_clase= MiClase.new
    #un_modulo= MiModulo.new
    #un_objeto= MiObjeto.new

    #ORIGEN
    Aspects.on MiClase do
      # definición de aspectos para las instancias de MiClase
      puts una_clase.class
    end

    Aspects.on MiModulo do
      # definición de aspectos para las instancias de MiModulo
      puts 'Hola, soy un modulo'
      #puts un_modulo.class
    end

    Aspects.on MiObjeto do
      # definición de aspectos para miObjeto
      puts 'Hola, soy un objeto'
      #puts un_objeto.class
    end
  end

  it 'crear un origen a partir de una ExpReg' do
    Aspects.on MiClase , /^Foo.*/ , /.*bar/ do
      # definición para las instancias de MiClase y cualquier clase o módulo
      # cuyo nombre comience con "Foo" o termine con "bar"
      clase1= MiClase.new
      foo1= MiClase.new
      foobar= MiClase.new

      nombre= clase1.class #Pasar a string. Ver como contener a otro.

      #block= {|una_clase| una_clase.include?(nombre)}
      #[clase1, foo1, foobar].select(block)
    end
  end

  # Aspects.on UnaClase, UnModulo, OtroModulo do
  #   # definición para las instancias de UnaClase, UnModulo u OtroModulo
  # end

  #   Aspects.on do
  #   # ...
  #   end
  #   # ArgumentError: wrong number of arguments (0 for +1)
  #   Aspects.on / NombreDeClaseQueNoExiste / do
  #   # ...
  #   end
  #   # ArgumentError: origen vacío
  #   Aspects.on / NombreDeClaseQueNoExiste /, / NombreDeClaseQueS í Existe / do
  #   # ...
  #   end
  #   # Exito!
  #
  #   Aspects.on MiClase , miObjeto do
  #   where << Condicion1 >>, << Condicion2 >>, ..., << CondicionN >>
  #   # Retorna los métodos que entienden miObjeto y las instancias de MiClase
  #   # que cumplen con todas las condiciones pedidas
  #   end

  #   it 'A saluda' do
  #     Aspects.on A do
  #       transform( where name ( /saludar/ )) do
  #         redirect_to( B.new)
  #       end
  #     end
  #     #A.new.saludar ("Mundo")
  #     soyA = A.new
  #     soyA.saludar("Mundo")
  #     expect(SoyA.saludar)_to eq("Hola, Mundo !")
  #   end
  #
  # # "Adiosín, Mundo"
  #
  #   Aspects.on B do
  #     transform( where name ( /saludar/ )) do
  #       inject ( x : "Chicos")
  #       redirect_to ( A . new)
  #     end
  #   end
  #   B . new . saludar ( "Mundo")
  # # "Hola, Chicos!"
  # =end

end