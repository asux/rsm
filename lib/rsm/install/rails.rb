module Rsm
  module Install
    class Rails < Thor::Group
      include Thor::Actions
      include Actions

      attr_reader :application_root, :worker_processes

      argument :name

      class_option :apps_root, :defualt => "/var/www", :aliases => "-r", :desc => "Rails apps root (default: /var/www)"

      class_option :user, :aliases => "-u", :default => "git", :desc => "Owners's user"
      class_option :group, :aliases => "-g", :default => "git", :desc => "Owners's group"

      class_option :git, :desc => "Git repository URL"
      class_option :tgz, :desc => "Install from TGZ (tar.gz)"
      class_option :tbz2, :desc => "Install from TBZ2 (tar.bz2)"

      class_option :worker_processes, :type => :numeric, :default => 2, :aliases => "-w", :desc => "Worker processes for use in Unicorn"

      def self.source_root
        File.expand_path('../../../..', __FILE__)
      end

      def set_destination_root
        @application_root = "#{options[:apps_root]}/#{name}"
        self.destination_root = @application_root
      end

      def download
        empty_directory application_root
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
            say "No source URI specified. Use --git, --tgz or --tbz2 option with URI passed"
            exit 1
          end
        end
      end

      def permissions
        inside application_root do
          empty_directory "log"
          empty_directory "tmp"
          run "chown #{options[:user]}:#{options[:group]} -R ."
          run "chmod 755 log tmp"
        end
      end

      def unicorn_config
        @worker_processes = options[:worker_processes]
        template "templates/unicorn.rb.erb", "config/unicorn.rb"
      end
    end
  end
end
