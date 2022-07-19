require "communify/version"
require 'communify/sms/sms_railtie' if defined?(Rails)

class Error < StandardError; end

  class Welcome 

    def self.message (variable = "Welcome")
      puts variable
    end

  end

