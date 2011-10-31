module Rsm
  module Thin
    class Restart < Rsm::Base

      def thin_restart
        run_with_bundler "thin restart -C #{application_root}/config/thin.#{options[:environment]}.yml"
      end

    end
  end
end