require 'communify'
require 'communify/workers/priority_worker'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                resource.save
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token
                puts resource.read_attribute_before_type_cast(:priority)

                Communify::Workers::PriorityWorker.perform_async(resource, resource.read_attribute_before_type_cast(:priority))
            end
        end
    end
end
