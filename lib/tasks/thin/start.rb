module Rsm
  module Thin
    class Start < Rsm::Base

      def thin_start
        run_ruby_binary "thin start -C #{application_root}/config/thin.yml"
      end

    end
  end
end