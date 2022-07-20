require 'twilio-ruby'
require 'communify'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                @client.messages.create(
                    from: Communify.sender_no,
                    to: resource.recipient_no,
                    body: resource.message
                )
            end
        end
    end
end
