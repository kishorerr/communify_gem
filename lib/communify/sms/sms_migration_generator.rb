require 'rails/generators/active_record'
require 'fileutils'

class SmsMigrationGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :methods, type: :array, default: [], banner: "method method"
  class_option :module, type: :string

  def create_sms_migration
    @module_name = options[:module]

    communify_dir_path = Rails.root.join 'db', 'migrate'    
    generator_path = communify_dir_path.join "#{file_name}.rb"

    migration_template "sms.erb", "#{communify_dir_path}/sms_#{table_name}.rb"
  end
  
  private

  def module?
    @module_name.present?
  end
  
  def methods?
    methods.any?
  end

end
