require 'communify/workers/priority_worker'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                if resource.save
                    time = resource.read_attribute_before_type_cast(:priority)
                    Communify::Workers::PriorityWorker.perform_in(time.minutes.from_now,resource.recipient_number, resource.message)
                else    
                    raise "Error => Resource has not been saved!!"
                end
            end
        end
    end
end
