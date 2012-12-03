# Empezar

A simple Ruby library to enforce a convention for configuration, logging and execution

## Install

    gem install empezar

## Usage

To start, you must create a `config` directory containing at least a `main.yaml` file with at least one configuration. Currently Empezar supports the `verbosity` flag, which can be setted to `silent` and the application's log will not be echoed in command line (otherwise it will be):

```yaml
#config/main.yaml
verbosity: normal # `silent` will silence stdout
```

Then create a ruby script anywhere in the folder and run it

```ruby
# script.rb
require 'empezar'

Runner.run        # Maps config/main.yaml to Configuration as SymbolMatrix
                  # Gets ready Log as a logger in log/main.log

Log.info "This will be logged and written in the shell"

Configuration.each do |key, value|
  Log.debug key, value
end
```

...and then 

    ruby script.rb

You can find this sample in the `sample` folder in this repo.

This is really short, so here, [have a picture of a monkey](http://i.dailymail.co.uk/i/pix/2011/07/04/article-2011051-0CDC0F0900000578-739_634x894.jpg) . Enjoy