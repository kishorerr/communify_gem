require 'rails/generators'
require 'rails/generators/active_record'

module Communify
  module Generators

    class SmsGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

    
      def copy_migration
        migration_template "sms_migration.erb", "db/migrate/create_communify_sms.rb", migration_version: migration_version
      end

      def copy_sms_model
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
