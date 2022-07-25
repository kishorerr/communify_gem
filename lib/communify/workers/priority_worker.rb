require 'twilio-ruby'
require 'sidekiq'
require 'communify'
require 'communify/controllers/sms_controller'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
            sidekiq_options retry: 0, dead: false

            def perform(recipient_number, message, resource_id, time, attempt)
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                @current_resource = CommunifySms.find(resource_id)
                begin
                    @client.messages.create(
                            from: Communify.sender_no,
                            to: recipient_number,
                            body: message
                            ) 
                    @current_resource.update_column(:attempt_count, attempt+1)
                    @current_resource.update_column(:message_status, "Message Delivered at #{DateTime.now}")
                rescue Twilio::REST::RestError => e
                    if attempt < Communify.attempt_count
                        Communify::Workers::PriorityWorker.perform_in(time.minutes.from_now, @current_resource.recipient_number, @current_resource.message, @current_resource.id, time, attempt+1)
                    else
                        @current_resource.update_column(:message_status, "Message Failed at #{DateTime.now} due to error => #{e}")
                    end
                end
            end
        end
    end
end
