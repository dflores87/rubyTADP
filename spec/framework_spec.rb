require 'rspec'
require_relative '../src/framework'

describe 'framework tests' do

  it 'dice mi pertenencia' do
    una_clase= MiClase.new
    #un_modulo= MiModulo.new
    #un_objeto= MiObjeto.new

    #ORIGEN
    a = Aspects.on MiClase, MiModulo do
      # definición de aspectos para las instancias de MiClase
      "tiene una clase"
    end
    puts a.origenes

    # Aspects.on MiModulo do
    #   # definición de aspectos para las instancias de MiModulo
    #   puts 'Hola, soy un modulo'
    #   #puts un_modulo.class
    # end
    #
    # Aspects.on MiObjeto do
    #   # definición de aspectos para miObjeto
    #   puts 'Hola, soy un objeto'
    #   #puts un_objeto.class
    # end
  end

  # it 'crear un origen a partir de una ExpReg' do

   end
  #
  # it 'crear un specto que no tenga origenes definidos. Deberia romper' do
  #   expect {
  #     Aspects.do do
  #       #....
  #     end
  #   }.to raise_error(ArgumentError)
  #
  # end

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