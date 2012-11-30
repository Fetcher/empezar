require 'spec_helper'

describe Empezar::Configuration do 
  it 'should be a Singleton' do 
    Empezar::Configuration.ancestors.should include Singleton
  end

  it 'should inherit from SymbolMatrix' do 
    Empezar::Configuration.superclass.should == SymbolMatrix
  end
end