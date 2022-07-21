require 'twilio-ruby'
require 'sidekiq'
require 'communify'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
        
            def perform(recipient_number, message, time)
                puts "HIIIIIIi"
                new_result=""
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
                    return new_result = "true"
                rescue Twilio::REST::RequestError => e
                    return new_result = "false"
                end
            end
        end
    end
end
