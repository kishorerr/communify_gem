require "communify/version"
require 'communify/railtie' if defined?(Rails)
require 'communify/generators/install/install_generator'
require 'communify/controllers/sms_controller'
module Communify
  class Error < StandardError; end

  class << self
    attr_accessor :account_sid, :auth_token

    def config
      yield self
    end
  end
end


