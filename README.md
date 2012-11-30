# Empezar

A simple Ruby library to enforce a convention for configuration, logging and execution

## Install

    gem install empezar

## Usage

```ruby
require 'empezar'

Runner.run        # Maps config/main.yaml to Configuration as SymbolMatrix
                  # Gets ready Log as a logger in log/main.log
```