require 'twilio-ruby'
require 'sidekiq'
require 'communify'
require 'communify/controllers/sms_controller'
module Communify
    module Workers 
        class PriorityWorker
            include Sidekiq::Worker
            sidekiq_options dead: false

            def perform(resource_id, recipient_number, message, time, attempt)
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                @client = Twilio::REST::Client.new account_sid, auth_token
                @current_resource = CommunifySms.find(resource_id)
                begin
                    topper = @client.messages.create(from: Communify.sender_no,to: recipient_number,body: message)
                rescue Twilio::REST::RestError => e
                    puts "ello #{topper}"
                    @current_resource.update_column(:attempt_count, attempt)
                    attempt = attempt +1
                    @current_resource.update_column(:message_status, "Message Failed at #{DateTime.now} due to error => #{e}")
                    if attempt < 4
                        sleep(time.minutes)
                        retry
                    end
                else
                    puts "ello #{topper}"
                    @current_resource.update_column(:attempt_count, attempt)
                    @current_resource.update_column(:message_status, "Message Delivered at #{DateTime.now}")
                end
            end
        end
    end
end
