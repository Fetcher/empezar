module Empezar
  class Log
    include Singleton
    @@logger = nil

    def self.instance
      @@logger
    end

    def self.start logger
      @@logger = logger
    end
  end
end

class Log
  class << self
    def method_missing *args
      if args.first == :warning
        args.shift
        Empezar::Log.instance.warn *args
      else
        Empezar::Log.instance.send *args
      end
    end
  end
end
