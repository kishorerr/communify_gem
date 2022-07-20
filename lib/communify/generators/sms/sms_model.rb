require 'rails/generators'


module Communify
  module Generators

    class SmsModelGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a SMS model"

      def copy_config
        template "sms_model.erb", "app/models/#{file_name}.rb"
      end
    end
  end
end