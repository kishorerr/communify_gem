require 'communify/workers/priority_worker'
require 'sidekiq/api'
module Communify
    module Controllers
        class Sms 
            def self.send_message(resource)
                if resource.save
                    resource.update_column(:message_status, "Message Queued at #{DateTime.now}")
                    time = resource.read_attribute_before_type_cast(:priority)
                    attempt = 1
                    result = Communify::Workers::PriorityWorker.perform_in(time.minutes.from_now, resource.id, resource.recipient_number, resource.message, time, attempt)
                    return resource.id
                else    
                    raise "Error => Resource has not been saved!!"
                end
            end
        end
    end
end
