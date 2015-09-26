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
  end

   it 'crear un origen a partir de una ExpReg' do

   end

   it 'crear un specto que no tenga origenes definidos. Deberia romper' do
   expect {
       Aspects.do do
         #....
       end
     }.to raise_error(ArgumentError)

   end

     it 'A saluda' do
       soyA = A.new
       soyA.saludar("Mundo")
       expect(SoyA.saludar)_to eq("Hola, Mundo !")
     end

  #Probar la Inyeccion Logica.
  instancia = MiClase.new
  instancia.m1(1, 2)
  #30
  instancia.x
  #10
  instancia = MiClase.new
  instancia.m2(10)
  #10
  instancia.m2(200)
  #400
  instancia = MiClase.new
  instancia.m3(10)
  instancia.x
#123

end