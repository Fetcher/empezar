require 'spec_helper'

describe Empezar::Log do 
  it 'should be a Singleton' do 
    Empezar::Log.ancestors.should include Singleton
  end

  describe '#instance' do 
    it 'should be as initialized in the start' do 
      logger_stub = stub 'logger'
      Empezar::Log.start logger_stub
      Empezar::Log.instance.should == logger_stub
    end
  end
end