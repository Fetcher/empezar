Feature: Configuration file scaffolding
  In order to setup a project easily
  As a developer using empezar conventions
  I want to have a command line tool to create a
    configuration file

@clean
Scenario: Creating a simple configuration file from a command
  Given I have the configuration 'to.many:values to.see.it:work i:1337'
  When I run `empezar` with that configuration
  Then I should have a 'config/main.yaml' file with
  """
  to:
    many: values
    see:
      it: work
  i: 1337
  """