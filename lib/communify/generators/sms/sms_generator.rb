require 'rails/generators'
require 'rails/generators/active_record'

module Communify
  module Generators
    class SmsGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

    
      def create_sms_migration
    
        communify_dir_path = Rails.root.join 'db', 'migrate'    
        # generator_path = communify_dir_path.join "#{file_name}.rb"
    
        migration_template "sms_migration.erb", "#{communify_dir_path}/create_communify_sms.rb", migration_version: migration_version
      end

      def create_sms_model
        template "sms_model.erb", "app/models/communify_sms.rb"
      end
      
      private
    
      def rails5_and_up?
        Rails::VERSION::MAJOR >= 5
      end
    
      def migration_version
        if rails5_and_up?
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    
    end
  end
end
