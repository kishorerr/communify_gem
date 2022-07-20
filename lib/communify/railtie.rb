module Communify
	def self.root
		File.dirname __dir__
	end

	class InstallRailtie < Rails::Railtie
		sms_generator_path = Communify::root.+'/communify/generators/sms/sms_migration_generator.rb'
		install_generator_path = Communify::root.+'/communify/generators/install/install_generator.rb'


		config.app_generators do
			require sms_generator_path
			require install_generator_path
		end
	end
end