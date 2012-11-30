require 'spec_helper'

describe Runner do 
  it 'should redirect random calls to Empezar::Runner' do 
    Empezar::Runner.should_receive :hola
    Runner.hola

    Empezar::Runner.should_receive :aaaaaaaa
    Runner.aaaaaaaa

    Empezar::Runner.should_receive(:oo=).with "hola"
    Runner.oo = "hola"
  end
end