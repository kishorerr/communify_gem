require "communify/version"
require 'communify/railtie' if defined?(Rails)
require 'communify/generators/install/install_generator'

module Communify
  class Error < StandardError; end

  class << self
    attr_accessor :account_sid, :auth_token, :sender_no

    def config
      yield self
    end

  end
end


