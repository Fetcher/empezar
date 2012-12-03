module Empezar
  class Runner
    def self.run argument = 'config/main.yaml'
      self.start_configuration argument
      self.start_logger
    end

    def self.start_configuration argument
      unless File.exist? argument
        raise ConfigurationFileMissingException, "The configuration file is missing from '#{argument}'"
      end
      Empezar::Configuration.instance.merge! SymbolMatrix.new argument
    end

    def self.start_logger
      Dir.mkdir 'log' unless Dir.exist? 'log'
      Empezar::Log.start Logger.new 'log/main.log', 'daily'
      if Empezar::Configuration.instance.has_key? :verbosity and Empezar::Configuration.instance.verbosity == 'silent'
      else
        Empezar::Log.instance.formatter = EchoingFormatter.new Logger::Formatter.new
      end
    end
  end
end

class Runner
  class << self
    def method_missing *args
      Empezar::Runner.send *args
    end
  end
end
