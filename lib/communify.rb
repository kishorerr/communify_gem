require "communify/version"
require 'communify/railtie' if defined?(Rails)
require 'communify/controllers/sms_controller'

class Error < StandardError; end

  class Welcome 

    def self.message (variable = "Welcome")
      puts variable
    end

  end

