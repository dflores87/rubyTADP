require 'rspec'
require_relative '../src/framework'

describe 'framework tests' do

  it 'dice una clase' do
    # g=MiClase.new
    # puts Aspects.on 1 do
    # end

    #ORIGEN
    Aspects.on MiClase do
      # definici�n de aspectos para las instancias de MiClase
      puts 'Hola, soy una clase.'
    end

    Aspects.on MiModulo do
      # definici�n de aspectos para las instancias de MiModulo
      puts 'Hola, soy una modulo.'
    end

    Aspects.on MiObjeto do
      # definici�n de aspectos para miObjeto
      puts 'Hola, soy una objeto.'
    end

  end
  # Aspects.on UnaClase, UnModulo, OtroModulo do
  #   # definici�n para las instancias de UnaClase, UnModulo u OtroModulo
  # end

  #   Aspects.on do
  #   # ...
  #   end
  #   # ArgumentError: wrong number of arguments (0 for +1)
  #   Aspects.on / NombreDeClaseQueNoExiste / do
  #   # ...
  #   end
  #   # ArgumentError: origen vac�o
  #   Aspects.on / NombreDeClaseQueNoExiste /, / NombreDeClaseQueS � Existe / do
  #   # ...
  #   end
  #   # Exito!
  #
  #   Aspects.on MiClase , miObjeto do
  #   where << Condicion1 >>, << Condicion2 >>, ..., << CondicionN >>
  #   # Retorna los m�todos que entienden miObjeto y las instancias de MiClase
  #   # que cumplen con todas las condiciones pedidas
  #   end
  #
  #  #EXPRESION REGULAR
  #   Aspects.on MiClase , /^Foo.*/ , /.*bar/ do
  #   # definici�n para las instancias de MiClase y cualquier clase o m�dulo
  #   # cuyo nombre comience con "Foo" o termine con "bar"
  #   end
  #
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
  # # "Adios�n, Mundo"
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