require 'empezar'

# Runs empezar with the default data
Runner.run  config_file: 'config/main.yaml',
            log_file: 'log/main.yaml',
            stdout: $stdout,
            arguments: ARGV