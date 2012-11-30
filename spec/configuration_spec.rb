require 'spec_helper'

describe Configuration do 
  it 'should redirect random calls to the instance of Empezar::Configuration' do 
    Empezar::Configuration.instance.should_receive :hola
    Configuration.hola

    Empezar::Configuration.instance.should_receive :aaaaaaaa
    Configuration.aaaaaaaa

    Empezar::Configuration.instance.should_receive(:oo=).with "hola"
    Configuration.oo = "hola"
  end
end