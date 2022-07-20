require 'rails/generators'
require 'rails/generators/active_record'
require 'fileutils'

module Communify
  module Generators
    MissingORMError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Communify initializer"
      class_option :orm, required: true

      def copy_initializer
        unless options[:orm]
          raise MissingORMError, <<-ERROR.strip_heredoc
          An ORM must be set to install Devise in your application.

          Be sure to have an ORM like Active Record or Mongoid loaded in your
          app or configure your own at `config/application.rb`.

            config.generators do |g|
              g.orm :your_orm_gem
            end
          ERROR
        end

        template "communify.rb", "config/initializers/communify.rb"
      end
    end
  end
end