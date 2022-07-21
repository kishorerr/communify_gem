require 'twilio-ruby'
require 'sidekiq'
require 'communify'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
        
            def perform(recipient_number, message)
                puts "HIIIIIIi"
                puts time

                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                begin
                    @client.messages.create(
                        from: Communify.sender_no,
                        to: recipient_number,
                        body: message
                    )
                rescue Twilio::REST::RestError => e

                end
            end
        end
    end
end
