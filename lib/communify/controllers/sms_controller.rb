require 'communify/workers/priority_worker'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                resource.update_column(:message_status, "Message Queued at #{DateTime.now}")
                if resource.save
                    time = resource.read_attribute_before_type_cast(:priority)
                    result = false
                    result = Communify::Workers::PriorityWorker.perform_in(time.minutes.from_now,resource.recipient_number, resource.message)
                    if result.eql?(true)
                        resource.update_column(:message_status, "Message Delivered at #{DateTime.now}")
                    end
                else    
                    raise "Error => Resource has not been saved!!"
                end
            end
        end
    end
end
