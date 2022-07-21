require 'twilio-ruby'
require 'communify'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                resource.save
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                Thread.new do
                    sleep(20.seconds)
                    @client = Twilio::REST::Client.new account_sid, auth_token
                    @client.messages.create(
                        from: Communify.sender_no,
                        to: resource.recipient_number,
                        body: resource.message
                    )
                    resource.save
                    
                end
            end
        end
    end
end
