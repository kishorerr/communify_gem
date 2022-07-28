require 'twilio-ruby'
require 'sidekiq'
require 'communify'
require 'communify/controllers/sms_controller'
module Communify
    module Workers 
        class SmsWorker
            include Sidekiq::Worker
            sidekiq_options dead: false, retry: false

            def perform(resource_id, recipient_number, message, time, attempt)
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                @current_resource = CommunifySms.find(resource_id)
                begin
                    twilio_message = @client.messages.create(from: Communify.sender_no,to: recipient_number,body: message)
                rescue Exception => e
                    @current_resource.update_column(:attempt_count, attempt)
                    attempt = attempt +1
                    @current_resource.update_column(:message_status, "Message failed at #{DateTime.now} due to error => #{e}")
                    if attempt < 4
                        sleep(time.minutes)
                        retry
                    end
                else
                    @current_resource.update_column(:message_sid, twilio_message.sid)
                    @current_resource.update_column(:attempt_count, attempt)
                    @current_resource.update_column(:message_status, "Message Delivered at #{DateTime.now}")
                end
            end
        end
    end
end
