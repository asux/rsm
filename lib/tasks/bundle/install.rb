module Rsm
  module Bundle
    class Install < Rsm::Base

      def check_and_install
        inside "." do
          run_ruby_binary "bundle check || bundle install"
        end
      end

    end
  end
end