require "communify/version"
require 'communify/generators/sms/sms_railtie' if defined?(Rails)

class Error < StandardError; end

  class Welcome 

    def self.message (variable = "Welcome")
      puts variable
    end

  end

