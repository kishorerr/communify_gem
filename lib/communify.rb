require "communify/version"
require 'communify/generators/install/install_generator'
require 'communify/generators/sms/sms_generator'
require 'communify/controllers/sms_controller'
require 'communify/workers/sms_worker'

module Communify
  class Error < StandardError; end

  class << self
    attr_accessor :account_sid, :auth_token, :sender_no

    def config
      yield self
    end

  end
end


