module Rsm
  module Thin
    class Stop < Rsm::Base

      def thin_stop
        run_with_bundler "thin stop -C #{application_root}/config/thin.#{options[:environment]}.yml"
      end

    end
  end
end