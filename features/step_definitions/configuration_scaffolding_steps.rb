Given /^I have the configuration '(.+?)'$/ do |smas|
  @configuration = smas
end

When /^I run `(.+?)` with that configuration$/ do |command|
  process = IO.popen "bin/#{command} #{@configuration} 2>&1"
  @result = process.read
  process.close
  @code = $?.exitstatus
end

Then /^I should have a '(.+?)' file with$/ do |path, content|
  @code.should == 0
  File.should exist path
  SymbolMatrix(path).should == SymbolMatrix(content)
end