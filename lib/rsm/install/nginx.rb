module Rsm
  module Install
    class Nginx < Thor::Group
      include Thor::Actions

      attr_reader :domain

      argument :name

      class_option :nginx_root, :default => "/etc/nginx", :aliases => "-n", :desc => "Nginx configuration root"
      class_option :domain, :aliases => "-d", :desc => "Server's domain"

      def self.source_root
        File.expand_path('../../../..', __FILE__)
      end

      def set_destination_root
        self.destination_root = options[:nginx_root]
      end

      def nginx_conf_include
        include_str = "include sites-enabled.d/*.conf;\n\t"
        unless File.read("#{options[:nginx_root]}/nginx.conf").include?(include_str)
          inject_into_file "nginx.conf", include_str, :before => "server {"
        end
      end

      def nginx_config
        @domain = options[:domain]
        @domain = `hostname` unless @domain
        template "templates/nginx-vhost.conf.erb", "sites-available.d/#{name}.conf"
      end

      def enable_nginx_site
        link_file "#{options[:nginx_root]}/sites-available.d/#{name}.conf", "sites-enabled.d/#{name}.conf"
      end

    end
  end
end