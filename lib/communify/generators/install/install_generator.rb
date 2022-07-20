require 'rails/generators'


module Communify
  module Generators

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Communify initializer"

      def create_initializer
        template "communify.erb", "config/initializers/communify.rb"
      end
    end
  end
end