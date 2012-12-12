require 'spec_helper'

describe Writer::SymbolMatrix do 
  describe '#initialize' do 
    it 'should set the argument as the source' do 
      source = stub 'source'
      writer = Writer::SymbolMatrix.new source
      writer.source.should == source
    end
  end

  describe '#serialization' do 
    it 'should transform the multidimentional hash into a simple dot and colons serialization' do 
      multidimentional = SymbolMatrix.new hola: {
          the: "start",
          asdfdf: 8989,
          of: {
            some: "multidimentional"
          }
        },
        stuff: "oops"
      
      writer = Writer::SymbolMatrix.new multidimentional
      writer.serialization.should == "hola.the:start hola.asdfdf:8989 hola.of.some:multidimentional stuff:oops"
    end

    context 'with argument' do 
      it 'should do the transformation appending the argument to each key-value pair' do 
        simple = SymbolMatrix.new mykey: "myvalue", otherkey: "othervalue"

        writer = Writer::SymbolMatrix.new simple
        writer.serialization("inside.").should == "inside.mykey:myvalue inside.otherkey:othervalue"
      end
    end  
  end
end