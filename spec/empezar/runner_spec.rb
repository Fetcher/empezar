require 'spec_helper'

describe Empezar::Runner do 
  describe '.run' do 
    context 'with params for stdout and config_file' do
      before do
        @stdout = stub 'stdout'
        @config_file = stub 'config file'
        @log_file = stub 'log file'
        @arguments = stub 'arguments'
        @params = {
          stdout: @stdout, 
          log_file: @log_file, 
          config_file: @config_file,
          arguments: @arguments
        }
      end

      it 'should call start_logger' do 
        Empezar::Runner.stub :start_configuration
        Empezar::Runner.should_receive(:start_logger)
          .with @log_file, @stdout 
        Empezar::Runner.run @params
      end
 
      it 'should call start_configuration' do 
        Empezar::Runner.stub :start_logger
        Empezar::Runner.should_receive(:start_configuration)
          .with @config_file, @arguments
        Empezar::Runner.run @params
      end
    end
  end

  describe '.start_logger' do 
    before do 
      @demo_logger = stub 'demo logger'
      @stdout = stub 'stdout'
      @log_file = 'log/main.log'
      Logger.should_receive(:new)
        .with(@log_file, 'daily').and_return @demo_logger
    end

    context 'normal conditions of pressure and temperature' do 
      it 'should initialize the log as logger pointing to log/main.log, daily with the EchoingFormatter' do 
        formatter = stub 'formatter'
        echoing_formatter = stub 'echoing formatter'

        Dir.should_receive(:exist?).with('log')
          .and_return true
        Empezar::Configuration.instance
          .should_receive(:has_key?).with(:verbosity)
          .and_return false

        Logger::Formatter.should_receive(:new)
          .and_return formatter
        Empezar::EchoingFormatter.should_receive(:new)
          .with(formatter, @stdout)
          .and_return echoing_formatter
        @demo_logger.should_receive(:formatter=)
          .with echoing_formatter

        Empezar::Log.should_receive(:start)
          .with @demo_logger
        Empezar::Log.should_receive(:instance)
          .and_return @demo_logger

        Empezar::Runner.start_logger @log_file, @stdout
      end
    end

    context 'the verbosity level is set to silent' do 
      it 'should not set the formatter as an echoing formatter' do 
        Empezar::EchoingFormatter.should_not_receive :new

        Empezar::Configuration.instance.should_receive(:has_key?).with(:verbosity).and_return true
        Empezar::Configuration.instance.should_receive(:verbosity).and_return 'silent'

        Empezar::Log.should_receive(:start).with @demo_logger

        Empezar::Runner.start_logger @stdout, @log_file
      end
    end

    context 'the dir log does not exist' do
      it 'should create the dir log' do 
        Empezar::Configuration.instance.should_receive(:has_key?).with(:verbosity).and_return true
        Empezar::Configuration.instance.should_receive(:verbosity).and_return 'silent'
        Dir.should_receive(:exist?).with('log').and_return false
        Dir.should_receive(:mkdir).with('log')

        Empezar::Log.should_receive(:start).with @demo_logger

        Empezar::Runner.start_logger @stdout, @log_file
      end
    end
  end

  describe '.start_configuration' do 
    before do 
      @arguments = stub 'arguments'
    end

    context 'the configuration file exists' do 
      before do 
        File.stub :exist? => true
        @config_stub = stub 'config'
        @joined_args = stub 'joined arguments'
        @extra_data = stub 'extra data'
      end
      
      it 'should initialize the configuration with the argument' do 
        SymbolMatrix.should_receive(:new).with('config/main.yaml')
          .and_return @config_stub
        Empezar::Configuration.instance.should_receive(:merge!)
          .with @config_stub

        @arguments.stub :join => @joined_args
        SymbolMatrix.should_receive(:new).with(@joined_args)
          .and_return @extra_data
        Empezar::Configuration.instance.stub :recursive_merge!

        Empezar::Runner
          .start_configuration 'config/main.yaml', @arguments
      end

      it 'should parse the arguments joined and merge them recursively into Configuration' do 
        SymbolMatrix.should_receive(:new).with('config/main.yaml')
          .and_return @config_stub
        Empezar::Configuration.instance.should_receive(:merge!)
          .with @config_stub

        @arguments.should_receive(:join).with(" ")
          .and_return @joined_args
        SymbolMatrix.should_receive(:new).with(@joined_args)
          .and_return @extra_data
        Empezar::Configuration.instance.should_receive(:recursive_merge!)
          .with @extra_data, true

        Empezar::Runner
          .start_configuration 'config/main.yaml', @arguments
      end
    end

    context 'the configuration file is missing' do 
      it 'should raise a relevant error' do
        File.should_receive(:exist?).with('config/main.yaml').and_return false
        expect { Empezar::Runner
            .start_configuration 'config/main.yaml', @arguments
        }.to raise_error Empezar::ConfigurationFileMissingException, 
          "The configuration file is missing from 'config/main.yaml'"
      end
    end
  end
end