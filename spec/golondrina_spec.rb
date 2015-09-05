require 'rspec'
require_relative '../src/Golondrina'

describe 'golondrinas' do
  let (:una_golondrina){
    Golondrina.new
  }

  it 'deberia perder energia cdo vuela' do
    una_golondrina.volar(10)
    expect(una_golondrina.energia).to eq(900)

  end

  it 'deberia ganar energia cdo come' do

  end

  class Aspect
    def self.on(*args, &block)
      "Hola!!!!"
    end
  end

  puts Aspect.on do

  end
end