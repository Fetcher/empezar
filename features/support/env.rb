require 'fast/fast'

$LOAD_PATH << File.expand_path("../../../lib", __FILE__)

require 'empezar'


module Helpers
  class StdOut < Array
    def puts element
      self.push element
    end
  end

  def fake_stdout
    @fake_stdout ||= StdOut.new
  end
end

World Helpers