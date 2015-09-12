#ORIGENES
class MiClase
  attr_accessor :pepito

  def initialize
    @pepito = pepito
  end

  def foo
  end

  private

  def bar
  end
end

module MiModulo
  attr_accessor :pepito2

  def initialize
    @pepito2 = pepito2
  end
end

class MiObjeto #Esta bien que sea una clase?

end

class Aspects #Es el padre del diseño.
  def self.on(*args, &block)
    args[0].class
    block.call
  end
end

=begin
#SELECTOR
Aspects.on MiClase do
  where name ( /fo{2}/ )
# array con el método foo (bar no matchea)
  where name ( /fo{2}/ ), name ( /foo/ )
# array con el método foo (foo matchea ambas regex)
  where name ( /^fi+/ )
# array vacío (ni bar ni foo matchean)
  where name ( /foo/ ), name ( /bar/ )
# array vacío (ni foo ni bar matchean ambas regex)
end

Aspects.on MiClase do
  where name ( /bar/ ), is_private
# array con el método bar
  where name ( /bar/ ), is_public
# array vacío
end

class MiClase2
  def foo ( p1 , p2 , p3 , p4 = 'a' , p5 = 'b' , p6 = 'c' )
  end
  def bar ( p1 , p2 = 'a' , p3 = 'b' , p4 = 'c' )
  end
end

#CUMPLE EXACTAMENTE N PARAMETROS
Aspects.on MiClase2 do
  where has_parameters ( 3 , mandatory )
# array con el método foo
  where has_parameters ( 6 )
# array con el método foo
  where has_parameters ( 3 , optional )
# array con los métodos foo y bar
end

class MiClase3
  def foo ( param1 , param2 )
  end
  def bar ( param1 )
  end
end

#CUMPLE EXACTAMENTE N PARAMETROS Y CON NOMBRE DE CIERTA ER
Aspects.on MiClase3 do
  where has_parameters ( 1 , /param.*/ )
# array con los el método bar
  where has_parameters ( 2 , /param.*/ )
# array con el método foo
  where has_parameters ( 3 , /param.*/ )
# array vacío
end

class MiClase4
  def foo1(p1)
  end
  def foo2(p1, p2)
  end
  def foo3(p1, p2, p3)
  end
end

#NO CUMPLE CON NADA
Aspects.on MiClase4 do
  where name(/foo\d/), neg ( has_parameters ( 1 ))
# array con los métodos foo2 y foo3
end

#TRANSFORMACION
Aspects.on MiClase , miObjeto do
  transform( where << Condicion1 >>, << Condicion2 >>, ..,<< CondicionN >>) do
  << Transformación1 >>
  << Transformación2 >>
  ...
end
end

#Inyección por parámetro
class MiClase5
  def hace_algo ( p1 , p2 )
    p1 + '-' + p2
  end
  def hace_otra_cosa ( p2 , ppp )
    p2 + ':' + ppp
  end
end
Aspects.on MiClase5 do
  transform( where has_parameters (1, /p2/ )) do
    inject ( p2 : ' bar ' )
  end
end
instancia = MiClase5 . new
instancia . hace_algo ( "foo" )
# "foo-bar"
instancia . hace_algo ( "foo" , "foo" )
# "foo-bar"
instancia . hace_otra_cosa ( "foo" , "foo" )
# "bar:foo"
Aspects.on MiClase5 do
  transform( where has_parameters ( 1 , /p2/ )) do
    inject ( p2 : proc { | receptor , mensaje , arg_anterior |
      "bar(#{mensaje}->#{arg_anterior})"
    })
  end
end
MiClase5 . new . hace_algo ( 'foo' , 'foo' )
# 'foo-bar(hace_algo->foo)'

#Redirección
class A
  def saludar ( x)
    "Hola, " + x
  end
end

class B
  def saludar ( x)
    "Adiosin, " + x
  end
end

#Inyección lógica
class MiClase6
  attr_accessor : x
  def m1 ( x , y )
    x + y
  end
  def m2 ( x )
    @x = x
  end
  def m3 ( x )
    @x = x
  end
end
Aspects.on MiClase6 do
  transform(where name ( /m1/ )) do
    before do | instance , cont , * args |
    @x = 10
    new_args = args . map { | arg | arg * 10 }
    cont . call ( self , nil , * new_args )
    end
  end
  transform(where name ( /m2/ )) do
    after do | instance , * args |
    if @x > 100
      2 * @x
    else
      @x
    end
    end
  end
  transform(where name ( /m3/ )) do
    instead_of do | instance , * args |
    @x = 123
    end
  end
end
instancia = MiClase6 . new
instancia . m1 ( 1 , 2 )
# 30
instancia . x
# 10
instancia = MiClase6 . new
instancia . m2 ( 10 )
# 10
instancia . m2 ( 200 )
# 400
instancia = MiClase6 . new
instancia . m3 ( 10 )
instancia . x
# 123
=end
