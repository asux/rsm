require 'pathname'

module Rsm
  class Base < Thor::Group
    include Thor::Actions
    include Actions

    SERVERS = [:unicorn, :thin]

    attr_reader :server, :worker_processes, :socket_per_worker

    argument :name

    class_option :apps_root, :default => "/var/www", :aliases => "-r", :desc => "Rails apps root"
    class_option :capistrano, :default => false, :aliases => "-c", :desc => "Application's Capistrano stage"

    class_option :server, :aliases => "-s", :default => :unicorn, :desc => "What server we will use"
    class_option :worker_processes, :type => :numeric, :default => 2, :aliases => "-w", :desc => "Worker processes of server we will use"
    class_option :environment, :aliases => "-e", :default => "production"

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

    def set_server
      @server = options[:server].to_sym
      raise "Unknown server #{options[:server].inspect}. Available is #{SERVERS}" unless SERVERS.include?(server)
      @socket_per_worker = (server == :thin)
    end

    def set_worker_processes
      @worker_processes = options[:worker_processes]
    end
  end
end