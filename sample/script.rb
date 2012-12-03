# script.rb
require 'empezar'
require 'pry'

Runner.run        # Maps config/main.yaml to Configuration as SymbolMatrix
                  # Gets ready Log as a logger in log/main.log

Log.info "This will be logged and written in the shell"

binding.pry
Configuration.each do |key, value|
  Log.debug key, value
end