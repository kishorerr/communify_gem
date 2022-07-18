# frozen_string_literal: true

require 'rails/generators/active_record'
require 'communify/generators/communify/orm_helpers'

module ActiveRecord
  module Generators
    class CommunifyGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      class_option :primary_key_type, type: :string, desc: "The type for primary key"

      include Communify::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def communify_migration
          migration_template "migration.rb", "#{migration_path}/devise_create_#{table_name}.rb", migration_version: migration_version
      end

      def migration_data
<<RUBY
      t.string :message,              null: false, default: ""
      t.string :sender_number, null: false, default: ""
      t.string :recipient_number, null: false, default: ""
RUBY
      end
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