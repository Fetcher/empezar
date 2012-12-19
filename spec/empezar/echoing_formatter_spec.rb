require 'spec_helper'

describe Empezar::EchoingFormatter do
  before do 
    @formatter_stub = stub 'formatter'
    @stdout = stub 'stdout'
  end

  describe '#initialize' do 
    it 'should receive a Formatter as an argument and store it as the wrapee' do
      my_formatter = Empezar::EchoingFormatter
        .new @formatter_stub, @stdout
      my_formatter.wrapee.should == @formatter_stub
    end

    it 'should receive an io as an argument and store it as the stdout' do 
      my_formatter = Empezar::EchoingFormatter
        .new @formatter_stub, @stdout
      my_formatter.stdout.should == @stdout
    end
  end

  describe '#call' do 
    context 'fatal error' do 
      it 'should puts to stdout with a bold red message' do 
        @formatter_stub.stub :call
        @stdout.should_receive(:puts).with Term::ANSIColor.bold Term::ANSIColor.red "message"

        formatter = Empezar::EchoingFormatter
          .new @formatter_stub, @stdout
        formatter.call "FATAL", nil, nil, "message"
      end
    end

    context 'error' do 
      it 'should puts to stdout with a red message' do 
        @formatter_stub.stub :call
        @stdout.should_receive(:puts).with Term::ANSIColor.red "message"

        formatter = Empezar::EchoingFormatter
          .new @formatter_stub, @stdout
        formatter.call "ERROR", nil, nil, "message"
      end
    end

    context 'warn' do
      it 'should puts to stdout with a yellow message' do 
        @formatter_stub.stub :call
        @stdout.should_receive(:puts).with Term::ANSIColor.yellow "message"

        formatter = Empezar::EchoingFormatter
          .new @formatter_stub, @stdout
        formatter.call "WARN", nil, nil, "message"
      end
    end

    context 'info' do 
      it 'should puts to stdout with a blue message' do 
        @formatter_stub.stub :call
        @stdout.should_receive(:puts).with Term::ANSIColor.blue "message"

        formatter = Empezar::EchoingFormatter
          .new @formatter_stub, @stdout
        formatter.call "INFO", nil, nil, "message"
      end
    end

    context 'unknown' do 
      it 'should puts to stdout with the message' do 
        @formatter_stub.stub :call
        @stdout.should_receive(:puts).with "message"

        formatter = Empezar::EchoingFormatter
          .new @formatter_stub, @stdout
        formatter.call "UNKNOWN", nil, nil, "message"
      end
    end

    context 'debug' do 
      it 'should puts to stdout with a dark message' do 
        @formatter_stub.stub :call
        @stdout.should_receive(:puts).with Term::ANSIColor.dark "message"

        formatter = Empezar::EchoingFormatter
          .new @formatter_stub, @stdout
        formatter.call "DEBUG", nil, nil, "message"
      end
    end

    it 'should call the #call of the wrapee with all the arguments' do 
      arg1 = stub; arg2 = stub; arg3 = stub; arg4 = stub
      @formatter_stub.should_receive(:call).with arg1, arg2, arg3, arg4

      formatter = Empezar::EchoingFormatter
        .new @formatter_stub, @stdout
      formatter.call arg1, arg2, arg3, arg4
    end
  end
end