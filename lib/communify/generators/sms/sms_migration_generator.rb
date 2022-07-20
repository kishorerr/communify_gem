require 'rails/generators'
require 'rails/generators/active_record'

module Communify
  module Generators
    class SmsMigrationGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
    
      argument :methods, type: :array, default: [], banner: "method method"
      class_option :primary_key_type, type: :string, desc: "The type for primary key"
    
      def create_sms_migration
    
        communify_dir_path = Rails.root.join 'db', 'migrate'    
        generator_path = communify_dir_path.join "#{file_name}.rb"
    
        migration_template "sms.erb", "#{communify_dir_path}/create_#{table_name}.rb", migration_version: migration_version
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
    
      def primary_key_type
        primary_key_string if rails5_and_up?
      end
    
      def primary_key_string
        key_string = options[:primary_key_type]
        ", id: :#{key_string}" if key_string
      end
    
    end
  end
end
