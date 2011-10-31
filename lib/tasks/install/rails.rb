module Rsm
  module Install
    class Rails < Rsm::Base

      attr_reader :socket, :host, :port

      class_option :user, :aliases => "-u", :default => "git", :desc => "Owners's user"
      class_option :group, :aliases => "-g", :default => "git", :desc => "Owners's group"

      class_option :git, :desc => "Git repository URL"
      class_option :tgz, :desc => "Install from TGZ (tar.gz)"
      class_option :tbz2, :desc => "Install from TBZ2 (tar.bz2)"

      class_option :socket, :aliases => "-S", :type => :boolean, :defualt => false, :desc => "Use socket"
      class_option :host, :aliases => "-h", :default => "127.0.0.1", :desc => "Application server host binding"
      class_option :port, :aliases => "-p", :default => 3000, :desc => "Application server port binding"

      def download
        empty_directory "."
        inside application_root do
          if options[:git]
            run "git clone #{options[:git]} ."
          elsif options[:tgz]
            fetch_temporary_archive(name, options[:tgz], :gz)
            unpack_compressed_archive(name, :gz)
          elsif options[:tbz2]
            fetch_temporary_archive(name, options[:tbz2], :bz2)
            unpack_compessed_archive(name, :bz2)
          else
            say "No source URI specified - skip download"
          end
        end
      end

      def define_vars
        @socket = options[:socket]
        @host = options[:host]
        @port = options[:port]
      end

      def unicorn_config
        template "unicorn.rb.erb", "config/unicorn.rb"
      end
      remove_task :unicorn_config

      def thin_config
        env = options[:environment]
        inside "." do
          cmd = "thin config -C config/thin.#{env}.yml -s #{options[:worker_processes]} -e #{env} -l log/thin.#{env}.log -P tmp/pids/thin.#{env}.pid"
          if socket
            cmd << " -S tmp/sockets/thin.#{env}.sock"
          else
            if host
              cmd << " -a #{host}"
            end
            if port
              cmd << " -p #{port}"
            end
          end
          run_with_bundler cmd
        end
      end
      remove_task :thin_config

      def server_config
        send("#{server}_config")
      end

      def permissions
        inside "." do
          empty_directory "log"
          empty_directory "tmp"
          run "chown #{options[:user]}:#{options[:group]} -R ."
          run "chmod 755 log tmp"
        end
      end
    end
  end
end
