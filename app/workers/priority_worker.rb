module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
        
            def perform(resource, time)
                sleep(time)
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
