require 'pathname'
require 'thor/group'

module Rsm
  class Install < Thor::Group
    include Thor::Actions

    argument :name

    class_option :nginx_root, :default => "/etc/nginx", :aliases => "-n", :desc => "Nginx configuration root"
    class_option :domain, :aliases => "-d", :desc => "Server's domain"

    class_option :user, :aliases => "-u", :default => "git", :desc => "Owners's user"
    class_option :group, :aliases => "-g", :default => "git", :desc => "Owners's group"

    class_option :git, :desc => "Git repository URL"
    class_option :tgz, :desc => "Install from TGZ (tar.gz)"
    class_option :tbz2, :desc => "Install from TBZ2 (tar.bz2)"

    class_option :worker_processes, :type => :numeric, :default => 2, :aliases => "-w", :desc => "Worker processes for use in Unicorn"

    def self.source_root
      File.expand_path('../../..', __FILE__)
    end

    def set_destination_root
      destination_root = "#{options[:apps_root]}/#{name}"
    end

    def nginx_conf_include
      nginx_conf = "#{options[:nginx_root]}/nginx.conf"
      include_str = "include sites-enabled.d/*.conf;\n"
      unless File.read(nginx_conf).include?(include_str)
        insert_into_file nginx_conf, include_str, :before => "server {\n"
      end
    end

    def nginx_config
      domain = options[:domain]
      domain = `hostname` unless domain
      template "templates/nginx-vhost.conf.erb", "#{options[:nginx_root]}/sites-available.d/#{name}.conf"
    end

    def enable_nginx_site
      create_link "#{options[:nginx_root]}/sites-enabled.d/#{name}.conf", "#{options[:nginx_root]}/sites-available.d/#{name}.conf"
    end

    def download
      app_root = "#{options[:apps_root]}/#{name}"
      if options[:git]
        run "git clone #{options[:git]} #{apps_root}"
      elsif options[:tgz]
        get options[:tgz], "/tmp/#{name}.tgz"
        run "tar -xzf /tmp/#{name}.tgz -C #{options[:apps_root]}"
      elsif options[:tbz2]
        get options[:tbz2], "/tmp/#{name}.tbz2"
        run "tar -xjf /tmp/#{name}.tbz2 -C #{options[:apps_root]}"
      else
        say "No source specified. Use --git, --tgz or --tbz2 option"
        exit 1
      end
    end

    def permissions
      app_root = "#{options[:apps_root]}/#{name}"
      run "chown #{opions[:user]}:#{options[:group]} -R #{apps_root}"
      run "chmod 755 -R #{apps_root}/{log,tmp}"
    end

    def unicorn_config
      worker_processes = options[:worker_processes]
      template "templates/unicorn.rb.erb", "config/unicorn.rb"
    end
  end
end