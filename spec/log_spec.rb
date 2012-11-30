require 'spec_helper'

describe Log do 
  it 'should redirect random calls to the instance of Empezar::Log' do 
    Empezar::Log.instance.should_receive :hola
    Log.hola

    Empezar::Log.instance.should_receive :aaaaaaaa
    Log.aaaaaaaa

    Empezar::Log.instance.should_receive(:oo=).with "hola"
    Log.oo = "hola"
  end
end