module Rsm
  module Install
    class Nginx < Rsm::Base
      attr_reader :domain

      class_option :nginx_root, :default => "/etc/nginx", :aliases => "-n", :desc => "Nginx configuration root"
      class_option :domain, :aliases => "-d", :desc => "Server's domain"

      def set_destination_root
        self.destination_root = options[:nginx_root]
      end

      def nginx_config_include_vhosts
        include_str = "include sites-enabled.d/*.conf;"
        unless File.read("#{destination_root}/nginx.conf").include?(include_str)
          inject_into_file "nginx.conf", "#{include_str}\n", :after => "index index.html;\n"
        end
      end

      def nginx_unicorn_config
        @domain = options[:domain]
        @domain = `hostname` unless @domain
        template "nginx-unicorn.conf.erb", "sites-available.d/#{name}.conf"
      end

      def enable_nginx_site
        link_file "#{destination_root}/sites-available.d/#{name}.conf", "sites-enabled.d/#{name}.conf"
      end

    end
  end
end