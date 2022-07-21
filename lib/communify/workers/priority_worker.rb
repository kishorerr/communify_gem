require 'twilio-ruby'
require 'sidekiq'
require 'communify'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
        
            def perform(resource, time)
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                sleep(time)
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
