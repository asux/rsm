module Rsm
  module Thin
    class Start < Rsm::Base

      def thin_start
        run_with_bundler "thin start -C #{application_root}/config/thin.yml"
      end

    end
  end
end