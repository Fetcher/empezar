module Empezar
  class Configuration < SymbolMatrix
    include Singleton
  end
end

class Configuration
  class << self
    def method_missing *args, &block
      Empezar::Configuration.instance.send *args, &block
    end
  end
end