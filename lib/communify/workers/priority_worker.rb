require 'twilio-ruby'
require 'sidekiq'
require 'communify'
require 'communify/controllers/sms_controller'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
            sidekiq_options retry: 3

            def perform(recipient_number, message)
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                begin
                    @client.messages.create(
                            from: Communify.sender_no,
                            to: recipient_number,
                            body: message
                            ) 
                            Communify::Controllers::Sms.resource.update_column(:message_status, "Message Delivered at #{DateTime.now}")
                rescue Twilio::REST::RestError => e
                    raise e
                end
            end
        end
    end
end
