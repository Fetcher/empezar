module Empezar
  class Scaffold
    def initialize smas, path
      Fast.file
        .write path, SymbolMatrix.new(smas).to.yaml
    end
  end
end