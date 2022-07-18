module Communify
	def self.root
		File.dirname __dir__
	end

	class MyRailtie < Rails::Railtie
		communify_generator_path = Communify::root.+'/communify/generators/active_record/communify_generator.rb'

		config.app_generators do
			require communify_generator_path
		end
	end
end