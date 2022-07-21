require 'communify/workers/priority_worker'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                resource.save
                puts resource.read_attribute_before_type_cast(:priority)

                Communify::Workers::PriorityWorker.perform_async(resource.recipient_number, resource.message, resource.read_attribute_before_type_cast(:priority))
            end
        end
    end
end
