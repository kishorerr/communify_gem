require 'rails/generators'
require 'rails/generators/active_record'
require 'fileutils'

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Communify initializer"

      def create_initializer
        template "communify.rb", "config/initializers/communify.rb"
      end
    end