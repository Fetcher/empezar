require 'spec_helper'

describe Empezar::Runner do 
  describe '.run' do 
    it 'should call start_logger' do 
      Empezar::Runner.stub :start_configuration
      Empezar::Runner.should_receive(:start_logger)
      Empezar::Runner.run
    end

    context 'without argument' do 
      it 'should call start_configuration with config/main.yaml' do 
        Empezar::Runner.stub :start_logger
        Empezar::Runner.should_receive(:start_configuration).with('config/main.yaml')
        Empezar::Runner.run
      end
    end

    context 'with argument' do 
      it 'should call start_configuration with the argument' do 
        Empezar::Runner.stub :start_logger
        Empezar::Runner.should_receive(:start_configuration).with('hola')
        Empezar::Runner.run 'hola'
      end
    end
  end

  describe '.start_logger' do 
    it 'should initialize the log as logger pointing to log/main.log, daily' do 
      Dir.should_receive(:exist?).with('log').and_return true
      demo_logger = stub 'logger'
      Logger.should_receive(:new).with('log/main.log', 'daily').and_return demo_logger
      Empezar::Log.should_receive(:start).with demo_logger

      Empezar::Runner.start_logger
    end

    context 'the dir log does not exist' do
      it 'should create the dir log' do 
        Dir.should_receive(:exist?).with('log').and_return false
        Dir.should_receive(:mkdir).with('log')

        demo_logger = stub 'logger'
        Logger.should_receive(:new).with('log/main.log', 'daily').and_return demo_logger
        Empezar::Log.should_receive(:start).with demo_logger

        Empezar::Runner.start_logger
      end
    end
  end

  describe '.start_configuration' do 
    context 'the configuration file exists' do 
      it 'should initialize the configuration with the argument' do 
        File.stub :exist? => true
        config_stub = stub 'config'
        SymbolMatrix.should_receive(:new).with('config/main.yaml').and_return config_stub
        Empezar::Configuration.instance.should_receive(:merge!).with(config_stub)

        Empezar::Runner.start_configuration 'config/main.yaml'
      end
    end

    context 'the configuration file is missing' do 
      it 'should raise a relevant error' do
        File.should_receive(:exist?).with('config/main.yaml').and_return false
        expect { Empezar::Runner.start_configuration 'config/main.yaml'
        }.to raise_error Empezar::ConfigurationFileMissingException, 
          "The configuration file is missing from 'config/main.yaml'"
      end
    end
  end
end