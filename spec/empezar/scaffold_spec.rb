require 'spec_helper'

describe Empezar::Scaffold do
  describe 'initialize' do 
    before do 
      @file_descriptor = stub 'file descriptor'
      @file_name = stub 'file name'
      @smas = stub 'smas serialization'
      @symbolmatrix = stub 'symbolmatrix'
      @writer = stub 'writer'
      @yaml_output = stub 'yaml output'
    end

    it 'should build a file with the YAML dump from the data' do 
      SymbolMatrix.should_receive(:new).with(@smas)
        .and_return @symbolmatrix
      @symbolmatrix.should_receive(:to).and_return @writer
      @writer.should_receive(:yaml).and_return @yaml_output

      Fast.should_receive(:file).and_return @file_descriptor

      @file_descriptor.should_receive(:write)
        .with(@file_name, @yaml_output)

      Empezar::Scaffold.new @smas, @file_name
    end
  end
end