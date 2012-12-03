# script.rb
require 'empezar'

Runner.run        # Maps config/main.yaml to Configuration as SymbolMatrix
                  # Gets ready Log as a logger in log/main.log

Log.info "This will be logged and writed in the shell"

Configuration.each do |key, value|
  Log.debug key, value
end