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
                    sleep(resource.priority.seconds)
                    @client = Twilio::REST::Client.new account_sid, auth_token
                    @client.messages.create(
                        from: Communify.sender_no,
                        to: resource.recipient_number,
                        body: resource.message
                    )
                    resource.update_column(:sent_at, DateTime.now)
                end
            end
        end
    end
end
