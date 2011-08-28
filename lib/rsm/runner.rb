module Rsm
  class Runner < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../..", __FILE__)
    end

    class_option :apps_root, :defualt => "/var/www", :aliases => "-r", :desc => "Rails apps root (default: /var/www)"

    register Rsm::Install::Nginx, "install:nginx", "install:nginx NAME", "Install Nginx config"
    register Rsm::Install::Rails, "install:rails", "install:rails NAME", "Install Rails application"

    desc "install NAME", "Install Nginx config and Rails application"
    def install(name)
      invoke "install:nginx"
      invoke "install:rails"
    end

    desc "unicorn NAME", "Run Unicorn server"
    def unicorn(name)
      app_root = Pathname.new("#{options[:apps_root]}/#{name}")
      rvmrc = app_root.join(".rvmrc")
      if rvmrc.exist?
        ruby_cmd = File.new(rvmrc).readline.strip + " exec"
      else
        ruby_cmd = "#{Thor::Util.ruby_command} -S"
      end
      run "#{ruby_cmd} unicorn_rails -D -c #{app_root.join("config", "unicorn.rb")}"
    end
  end
end