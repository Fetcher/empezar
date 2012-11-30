module Empezar
  class Configuration < SymbolMatrix
    include Singleton
  end
end

class Configuration
  class << self
    def method_missing *args
      Empezar::Configuration.instance.send *args
    end
  end
end