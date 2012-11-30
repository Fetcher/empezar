module Empezar
  class Runner
    def self.run argument = 'config/main.yaml'
      self.start_logger
      self.start_configuration argument
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
