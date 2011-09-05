module Rsm
  module Bundle
    class Update < Rsm::Base

      def update
        inside "." do
          run_ruby_binary "bundle update"
        end
      end

    end
  end
end