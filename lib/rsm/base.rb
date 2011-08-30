require 'pathname'

module Rsm
  class Base < Thor::Group
    include Thor::Actions
    include Actions

    argument :name

    class_option :apps_root, :defualt => "/var/www", :aliases => "-r", :desc => "Rails apps root (default: /var/www)"
    class_option :capistrano, :defualt => false, :aliases => "-c", :desc => "Application's Capistrano stage"

    def self.source_root
      File.expand_path('../../../templates', __FILE__)
    end

    def application_root
      unless @application_root
        @application_root = if options[:capistrano]
          "#{options[:apps_root]}/#{name}/#{options[:capistrano]}/current"
        else
          "#{options[:apps_root]}/#{name}"
        end
        @application_root = Pathname.new(@application_root)
        say "Application root: #{@application_root}"
      end
      @application_root
    end
    remove_task :application_root

  end
end