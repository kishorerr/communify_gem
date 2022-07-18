# frozen_string_literal: true

module Communify
    module Generators
      module OrmHelpers
        private
  
        def migration_exists?(table_name)
          Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_communify_#{table_name}.rb$/).first
        end
  
        def migration_path
          if Rails.version >= '5.0.3'
            db_migrate_path
          else
            @migration_path ||= File.join("db", "migrate")
          end
        end
      end
    end
  end