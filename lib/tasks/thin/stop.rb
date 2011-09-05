module Rsm
  module Thin
    class Stop < Rsm::Base

      def thin_stop
        run_ruby_binary "thin stop -C #{application_root}/config/thin.yml"
      end

    end
  end
end