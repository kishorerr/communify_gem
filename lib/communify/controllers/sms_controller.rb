require 'communify/workers/priority_worker'
require 'sidekiq/api'
module Communify
    module Controllers
        class Sms 
            class << self
                attr_accessor :resource

                def send_message (resource)
                    Sms.new(resource)
                    if resource.save
                        resource.update_column(:message_status, "Message Queued at #{DateTime.now}")
                        time = resource.read_attribute_before_type_cast(:priority)
                        result = Communify::Workers::PriorityWorker.perform_in(time.minutes.from_now,resource.recipient_number, resource.message)
                        return result
                    else    
                        raise "Error => Resource has not been saved!!"
                    end
                end
            end            
        end
    end
end
