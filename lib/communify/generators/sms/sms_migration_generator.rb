class DataMigrationGenerator < Rails::Generators::NamedBase
    def create_data_migration_file
      timestamp = Time.zone.now.to_s.tr('^0-9', '')[0..13]
      filepath = "db/migrate/#{timestamp}_#{file_name}.rb"
  
      create_file filepath, <<-FILE
      # frozen_string_literal: true
  
      class #{class_name} < ActiveRecord::Migration[7.0]
        def change
            create_table :todos do |t|
                t.string :title
                t.string :created_by
          
                t.timestamps
              end
        end
      end
      FILE
    end
  end