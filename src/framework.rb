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

  def foo( p1, p2, p3, p4 = 'a', p5 = 'b', p6 = 'c')
  end
  def bar( p1, p2 = 'a', p3 = 'b', p4 = 'c')
  end

  def foo( param1, param2)
  end
  def bar( param1)
  end

  def foo1(p1)
  end
  def foo2(p1, p2)
  end
  def foo3(p1, p2, p3)
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

class Aspects #Es el padre del dise�o.
  attr_accessor :origenes

  def initialize(*args)
    self.origenes = self.resolve_origins(args)
  end

  def self.on(*args, &block)
    aspecto = Aspects.new *args
    #aspecto.instance_eval block
    aspecto
  end

  def resolve_origins(args)
    agregar = []
    args.each do |arg|
      if (arg.is_a? Class)
        puts "es una clase"
        #agregar +=arg.to_s
      end
      if (arg.is_a? Module)
        puts "es un modulo"
        #agregar +=arg.to_s
      end
    end
    agregar
  end
end

Aspects.on MiClase do
# definici�n de aspectos para las instancias de MiClase
end

Aspects.on MiModulo do
# definici�n de aspectos para las instancias de MiModulo
end

miObjeto= MiObjeto.new

Aspects.on miObjeto do
# definici�n de aspectos para miObjeto
end

#Aspects.initialize MiClase, MiModulo, MiModulo
=begin
Aspects.on UnaClase, UnModulo, OtroModulo do #on:Agarra los args y un bloque.
# definici�n para las instancias de UnaClase, UnModulo u OtroModulo
end
=end
Aspects.on MiClase, /^Foo.*/, /.*bar/ do
  # definici�n para las instancias de MiClase y cualquier clase o m�dulo
  # cuyo nombre comience con "Foo" o termine con "bar"
=begin
  clase1= MiClase.new
  # foo1= MiClase.new
  # foobar= MiClase.new

  nombre= clase1.class #Pasar a string. Ver como contener a otro.
  puts %s{nombre}

  #block= {|una_clase| una_clase.include?(%s{foo})}
  #[%s{clase1}, foo1, %s{foobar}].select(block)
=end
end

Aspects.on do
  # ...
end
# ArgumentError: wrong number of arguments (0 for +1)

Aspects.on /NombreDeClaseQueNoExiste/ do
# ...
end
# ArgumentError: origen vac�o

Aspects.on /NombreDeClaseQueNoExiste/, /NombreDeClaseQueSiExiste/ do
# ...
end
# Exito!


#En este punto se pide implementar un mensaje w here , accesible desde dentro del contexto
#de los Or�genes, que reciba un conjunto de condiciones por par�metro.
#Los m�todos retornados no solo ser�n aquellos definidos en la clase o m�dulo inmediato,
#sino todos los de su jerarqu�a.
Aspects.on MiClase, miObjeto do
=begin
  where <<Condicion1>>, <<Condicion2>>, <<CondicionN>>
  # Retorna los m�todos que entienden miObjeto y las instancias de MiClase
  # que cumplen con todas las condiciones pedidas
=end
end

#SELECTOR: Esta condici�n se cumple cuando el selector del m�todo respeta una cierta regex.
Aspects.on MiClase do
  where name(/fo{2}/)
# array con el m�todo foo (bar no matchea)
  where name( /fo{2}/), name(/foo/)
# array con el m�todo foo (foo matchea ambas regex)
  where name(/^fi+/)
# array vac�o (ni bar ni foo matchean)
  where name(/foo/), name(/bar/)
# array vac�o (ni foo ni bar matchean ambas regex)
end

#VISIBILIDAD: Se cumple si el m�todo es privado o p�blico.
Aspects.on MiClase do
  where name(/bar/), is_private
# array con el m�todo bar
  where name(/bar/), is_public
# array vac�o
end

#CANTIDAD DE PARAMETROS: Debe poder establecerse una condici�n que se cumpla si el m�todo tiene
#                        exactamente N par�metros obligatorios, opcionales o ambos.
#CUMPLE EXACTAMENTE N PARAMETROS
Aspects.on MiClase do
  where has_parameters(3, mandatory)
# array con el m�todo foo
  where has_parameters(6)
# array con el m�todo foo
  where has_parameters(3, optional)
# array con los m�todos foo y bar
end

#NOMBRE DE PARAMETROS: Esta condici�n se cumple si el m�todo tiene exactamente N par�metros cuyo
#                      nombre cumple cierta regex.
#CUMPLE EXACTAMENTE N PARAMETROS Y CON NOMBRE DE CIERTA ER
Aspects.on MiClase do
  where has_parameters( 1, /param.*/)
# array con los el m�todo bar
  where has_parameters( 2, /param.*/)
# array con el m�todo foo
  where has_parameters( 3, /param.*/)
# array vac�o
end

#NEGACION: Esta condici�n recibe otras condiciones por par�metro y se cumple cuando ninguna
#          de ellas se cumple.
#NO CUMPLE CON NADA
Aspects.on MiClase do
  where name(/foo\d/), neg(has_parameters(1))
# array con los m�todos foo2 y foo3
end

#TRANSFORMACION: Se pide aplicar transformaciones sobre todos los m�todos que matchean todas las condiciones.
#Cuando los or�genes son m�dulos o clases, todas sus instancias se ver�n afectadas.
#Cuando el origen sea una instancia, s�lo �sa misma ser� afectada por las transformaciones.
Aspects.on MiClase, miObjeto do
=begin
  transform(where <<Condicion1>>, <<Condicion2>>, <<CondicionN>>) do
  <<Transformaci�n1>>
  <<Transformaci�n2>>
  #...hasta el infinito y mas alla!
#Debe ser posible aplicar m�ltiples transformaciones (sucesivas o no) para las mismas
#Condiciones u Origen.
end
=end
end

=begin
#Inyecci�n por par�metro
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

#Redirecci�n
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

#Inyecci�n l�gica
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
