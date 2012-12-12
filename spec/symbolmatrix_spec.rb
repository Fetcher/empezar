require 'spec_helper'

describe SymbolMatrix do 
  it 'should include Discoverer::Writer' do 
    SymbolMatrix.ancestors.should include Discoverer::Writer
  end
end