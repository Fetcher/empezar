require 'spec_helper'

describe "running with defaults" do 
  it 'should use config/main.yaml, log/main.yaml, ARGV and $stdout' do 
    Empezar::Runner.should_receive(:run)
      .with(
      config_file: "config/main.yaml",
      log_file: "log/main.yaml",
      stdout: $stdout,
      arguments: ARGV
    )

    require 'empezar/run'
  end
end