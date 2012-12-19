Feature: Starting up an app with Empezar
  In order to have all common needs covered for when  
    developing a new app
  As a Ruby developer
  I want to have Empezar dealing with log, configuration and 
    command line parameters setup for me

@clean
Scenario: Very simple setup, no args
  Given the config file "config/main.yaml"
  """
  data: 90
  """
  When I start the runner
  Then I should have 'data' with value 90 in Configuration
  When I info "Hello World" in the Log
  Then I should see "Hello World" in blue in command line
  And I should see "Hello World" in the "log/main.log" file

@clean
Scenario: App with some arguments
  Given the config file "config/main.yaml"
  """
  data: 89
  client:
    host: localhost
    path: /
  """
  And the command line arguments
  """
  client.port:8080 more:34
  """
  When I start the runner
  Then I should have 'data' with value 89 in Configuration
  And I should have 'more' with value 34 in Configuration
  And I should have 8080 in 'port' in 'client'
  And I should have "localhost" in 'host' in 'client'
  And I should have "/" in 'path' in 'client'