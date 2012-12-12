module Writer
  class SymbolMatrix
    attr_accessor :source

    def initialize source
      @source = source
    end

    def serialization prefix = ""
      text = ""
      @source.each do |key, value|
        if value.is_a? Hash
          text += value.to.serialization(prefix + key.to_s + ".") +" "
        else
          text += "#{prefix}#{key}:#{value} "
        end
      end
      text[0..-2]
    end
  end
end