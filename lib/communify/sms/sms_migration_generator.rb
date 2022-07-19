require 'rails/generators'
require 'fileutils'

class SmsMigrationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :methods, type: :array, default: [], banner: "method method"
  class_option :module, type: :string

  def create_service_file
    @module_name = options[:module]

    communify_dir_path = Rails.root.join 'db', 'migrate'    
    generator_path = communify_dir_path.join "#{file_name}.rb"

    template "sms.erb", generator_path
  end
  
  private

  def module?
    @module_name.present?
  end
  
  def methods?
    methods.any?
  end

end