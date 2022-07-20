require 'twilio-ruby'
require 'communify'
module Communify
    module Controllers
        class Sms 
            # attr_accessor :account_sid, :auth_token

            def self.send_message (message = "Hello")
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                @client.messages.create(
                    from: Communify.sender_no,
                    to: '+917356610002',
                    body: message
                )
            end
        end
    end
end
