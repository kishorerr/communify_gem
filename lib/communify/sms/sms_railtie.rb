module Communify
	module Sms 
		def self.root
			File.dirname __dir__
		end
	
		class SmsRailtie < Rails::Railtie
			sms_generator_path = Communify::Sms::root.+'/communify/sms/sms_migration_generator.rb'
	
			config.app_generators do
				require sms_generator_path
			end
		end
	end
end