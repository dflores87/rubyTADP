class Golondrina
  attr_accessor :energia

  def initialize
    self.energia = 1000

  end


  def volar (km)
    self.energia -= 10 * km

    def comer (gramos)
      self.energia += 5 * gramos

    end
  end
end


