require "communify/version"
require 'communify/railtie' if defined?(Rails)
require 'communify/generators/install/install_generator'
require 'communify/controllers/sms_controller'
require 'communify/workers/priority_worker'

module Communify
  class Error < StandardError; end

  class << self
    attr_accessor :account_sid, :auth_token, :sender_no, :retry_count

    def config
      yield self
    end

  end
end


