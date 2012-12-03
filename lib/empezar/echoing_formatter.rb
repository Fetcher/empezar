module Empezar
  class EchoingFormatter
    attr_accessor :wrapee

    def initialize wrapee
      @wrapee = wrapee
    end

    def call severity, datetime, progname, message
      case severity
        when Logger::Severity::FATAL, "FATAL"
          $stdout.puts Term::ANSIColor.bold Term::ANSIColor.red message
        when Logger::Severity::ERROR, "ERROR"
          $stdout.puts Term::ANSIColor.red message
        when Logger::Severity::WARN, "WARN"
          $stdout.puts Term::ANSIColor.yellow message
        when Logger::Severity::INFO, "INFO"
          $stdout.puts Term::ANSIColor.blue message
        when Logger::Severity::DEBUG, "DEBUG"
          $stdout.puts Term::ANSIColor.dark message
        when Logger::Severity::UNKNOWN, "UNKNOWN"
          $stdout.puts message
      end

      wrapee.call severity, datetime, progname, message
    end
  end
end