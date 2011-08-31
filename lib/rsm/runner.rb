module Rsm
  class Runner < Thor
    include Thor::Actions

    desc "version", "RSM gem version"
    def version
      require 'rsm/version'
      say "RSM version #{Rsm::VERSION}"
    end

    register Rsm::Install::Nginx, "install:nginx", "install:nginx NAME", "Install Nginx config"
    register Rsm::Install::Rails, "install:rails", "install:rails NAME", "Install Rails application"

    desc "install NAME", "Install Nginx config and Rails application"
    def install(name)
      invoke "install:nginx"
      invoke "install:rails"
    end

    desc "unicorn NAME", "Run Unicorn server"
    def unicorn(name)
      invoke Rsm::Unicorn
    end
  end
end