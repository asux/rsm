module Rsm
  module Install
    class Nginx < Rsm::Base
      attr_reader :domain, :rewrite_www, :auth_basic, :auth_basic_realm, :auth_basic_user_file

      class_option :nginx_root, :default => "/etc/nginx", :aliases => "-n", :desc => "Nginx configuration root"
      class_option :domain, :aliases => "-d", :desc => "Server's domain"
      class_option :rewrite_www, :type => :boolean, :default => false, :desc => "Use www-subdomain rewriting"

      class_option :auth_basic, :type => :boolean, :default => false, :aliases => "-a", :desc => "Use auth_basic"
      class_option :auth_basic_realm, :desc => "auth_basic realm or capitalized NAME unless set"
      class_option :auth_basic_user_file, :default => "htpasswd", :desc => "auth_basic user file relative path"

      def set_destination_root
        self.destination_root = options[:nginx_root]
      end

      def nginx_config_include_vhosts
        include_str = "include sites-enabled.d/*.conf;"
        unless File.read("#{destination_root}/nginx.conf").include?(include_str)
          inject_into_file "nginx.conf", "#{include_str}\n", :after => "index index.html;\n"
        end
      end

      def nginx_server_config
        @domain = options[:domain]
        unless @domain
          @domain = `hostname -f`.strip
          @domain = "#{name}.#{@domain}"
        end

        @rewrite_www = options[:rewrite_www]

        @auth_basic = options[:auth_basic]
        @auth_basic_realm = options[:auth_basic_realm]
        @auth_basic_realm = name.to_s.capitalize unless @auth_basic_realm
        @auth_basic_user_file = options[:auth_basic_user_file]

        template "nginx-server.conf.erb", "sites-available.d/#{domain}.conf"
      end

      def enable_nginx_site
        link_file "#{destination_root}/sites-available.d/#{domain}.conf", "sites-enabled.d/#{domain}.conf" unless FileTest.symlink?("#{destination_root}/sites-enabled.d/#{domain}.conf")
      end

    end
  end
end