require 'spec_helper'

describe Log do 
  context 'the call matches an existing method of an ancestor of Log' do
    it 'should not redirect it' do 
      allow_message_expectations_on_nil
      Empezar::Log.instance.should_not_receive :should_receive
      Log.should_receive :a
      Log.a
    end
  end

  context 'the call matches nothing' do
    it 'should redirect random calls to the instance of Empezar::Log' do 
      allow_message_expectations_on_nil
      Empezar::Log.instance.should_receive :hola
      Log.hola

      Empezar::Log.instance.should_receive :aaaaaaaa
      Log.aaaaaaaa

      Empezar::Log.instance.should_receive(:oo=).with "hola"
      Log.oo = "hola"
    end
  end
end