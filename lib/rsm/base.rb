require 'pathname'

module Rsm
  class Base < Thor::Group
    include Thor::Actions
    include Actions

    argument :name

    class_option :apps_root, :default => "/var/www", :aliases => "-r", :desc => "Rails apps root"
    class_option :capistrano, :default => false, :aliases => "-c", :desc => "Application's Capistrano stage"


    def self.template_path
      Thor::Util.snake_case(name.to_s).squeeze(":").gsub(":", "/")
    end
    
    def self.source_root
      File.expand_path("../../../templates/#{template_path}", __FILE__)
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