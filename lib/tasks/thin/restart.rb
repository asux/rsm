module Rsm
  module Thin
    class Restart < Rsm::Base

      def thin_restart
        run_ruby_binary "thin restart -C #{application_root}/config/thin.yml"
      end

    end
  end
end