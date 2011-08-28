require "pathname"
require "thor"

module Rsm
  class Runner < Thor
    include Thor::Actions

    register Rsm::Install, "install", "install NAME", "Install Rails application"

    def self.source_root
      File.expand_path("../..", __FILE__)
    end

    class_option :apps_root, :defualt => "/var/www", :aliases => "-r", :desc => "Rails apps root (default: /var/www)"

    desc "unicorn NAME", "Run Unicorn server"
    def unicorn(name)
      app_root = Pathname.new("#{options[:apps_root]}/#{name}")
      rvmrc = app_root.join(".rvmrc")
      if rvmrc.exist?
        ruby_cmd = File.new(rvmrc).readline.strip + " exec"
      else
        ruby_cmd = "ruby -S"
      end
      run "#{ruby_cmd} unicorn_rails -D -c #{app_root.join("config", "unicorn.rb")}"
    end
  end
end