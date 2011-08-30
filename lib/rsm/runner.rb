module Rsm
  class Runner < Thor
    include Thor::Actions

    register Rsm::Install::Nginx, "install:nginx", "install:nginx NAME", "Install Nginx config"
    register Rsm::Install::Rails, "install:rails", "install:rails NAME", "Install Rails application"
    register Rsm::Unicorn, "unicorn", "unicorn NAME", "Run Unicorn server"

    desc "install NAME", "Install Nginx config and Rails application"
    def install(name)
      invoke "install:nginx"
      invoke "install:rails"
    end

    desc "version", "RSM gem version"
    def version
      require 'rsm/version'
      say "RSM version #{Rsm::VERSION}"
    end
  end
end