require 'twilio-ruby'
require 'sidekiq'
require 'communify'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
        
            def perform(recipient_number, message, time)
                puts "HIIIIIIi"
                result=""
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                sleep(time.minutes)
                begin
                    @client.messages.create(
                        from: Communify.sender_no,
                        to: recipient_number,
                        body: message
                    )
                    result = "true"
                rescue Twilio::REST::RequestError => e
                    result = "false"
                end
            end
        end
    end
end
