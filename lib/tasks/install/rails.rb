module Rsm
  module Install
    class Rails < Rsm::Base

      class_option :user, :aliases => "-u", :default => "git", :desc => "Owners's user"
      class_option :group, :aliases => "-g", :default => "git", :desc => "Owners's group"

      class_option :git, :desc => "Git repository URL"
      class_option :tgz, :desc => "Install from TGZ (tar.gz)"
      class_option :tbz2, :desc => "Install from TBZ2 (tar.bz2)"

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

      def permissions
        inside "." do
          empty_directory "log"
          empty_directory "tmp"
          run "chown #{options[:user]}:#{options[:group]} -R ."
          run "chmod 755 log tmp"
        end
      end

      def unicorn_config
        template "unicorn.rb.erb", "config/unicorn.rb"
      end
      remove_task :unicorn_config

      def thin_config
        inside "." do
          run_ruby_binary "thin config -C config/thin.yml -S tmp/sockets/thin.sock -s #{options[:worker_processes]} -e #{options[:environment]}"
        end
      end
      remove_task :thin_config

      def server_config
        send("#{server}_config")
      end

    end
  end
end
