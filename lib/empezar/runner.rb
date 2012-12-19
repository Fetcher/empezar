module Empezar
  class Runner
    def self.run params
      self.start_configuration params[:config_file], params[:arguments]
      self.start_logger params[:log_file], params[:stdout]
    end

    def self.start_configuration config_file, arguments
      unless File.exist? config_file
        raise ConfigurationFileMissingException, "The configuration file is missing from '#{config_file}'"
      end
      Empezar::Configuration.instance.merge! SymbolMatrix.new config_file
      Empezar::Configuration.instance.recursive_merge! SymbolMatrix.new arguments.join " "
    end

    def self.start_logger log_file, stdout
      Dir.mkdir 'log' unless Dir.exist? 'log'
      Empezar::Log.start Logger.new 'log/main.log', 'daily'
      if Empezar::Configuration.instance.has_key? :verbosity and Empezar::Configuration.instance.verbosity == 'silent'
      else
        Empezar::Log.instance.formatter = EchoingFormatter.new Logger::Formatter.new, stdout
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
