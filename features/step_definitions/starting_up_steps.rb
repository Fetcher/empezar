Given /^the config file "(.+?)"$/ do |path, content|
  Fast.file.write path, content
end

When /^I start the runner$/ do 
  @arguments ||= []
  Runner.run(
    stdout: fake_stdout, 
    config_file: 'config/main.yaml', 
    log_file: 'log/main.log',
    arguments: @arguments
  )
end

Then /^I should have '(.+?)' with value (\d+) in Configuration$/ do |key, value|
  Configuration.send(key.to_sym).should == value.to_i
end

When /^I info "(.+?)" in the Log$/ do |text|
  Log.info text
end

Then /^I should see "(.+?)" in blue in command line$/ do |text|
  fake_stdout.last.should == Term::ANSIColor.blue(text)
end

And /^I should see "(.+?)" in the "(.+?)" file$/ do |text, file|
  Fast.file.read(file).should include text
end

Given /^the command line arguments$/ do |argument_line|
  @arguments = argument_line.split " "
end

Then /^I should have (\d+) in '(.+?)' in '(.+?)'$/ do |value, subkey, key|
  Configuration.send(key.to_sym).send(subkey.to_sym)
    .should == value.to_i
end

Then /^I should have "(.+?)" in '(.+?)' in '(.+?)'$/ do |value, subkey, key|
  Configuration.send(key.to_sym).send(subkey.to_sym)
    .should == value
end