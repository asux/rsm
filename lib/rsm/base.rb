require 'pathname'

module Rsm
  class Base < Thor::Group
    include Thor::Actions
    include Actions

    argument :name

    class_option :apps_root, :default => "/var/www", :aliases => "-r", :desc => "Rails apps root"
    class_option :capistrano, :default => false, :aliases => "-c", :desc => "Application's Capistrano stage"

    class_option :verbose, :default => false, :aliases => "-V", :desc => "Verbose output"

    def self.template_path
      Thor::Util.snake_case(name.to_s).squeeze(":").gsub(":", "/")
    end

    def self.source_root
      File.expand_path("../../../templates/#{template_path}", __FILE__)
    end

    def set_destination_root
      self.destination_root = application_root.to_s
    end
  end
end