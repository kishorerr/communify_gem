require 'lib/communify'
require 'app/worker/priority_worker'
module Communify
    module Controllers
        class Sms 
            def self.send_message (resource)
                resource.save
                account_sid = Communify.account_sid
                auth_token = Communify.auth_token

                PriorityWorker.perform_async(resource, resource.read_attribute_before_type_cast(:priority))
            end
        end
    end
end
