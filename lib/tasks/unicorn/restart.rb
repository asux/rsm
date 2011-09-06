module Rsm
  module Unicorn
    class Restart < Rsm::Base
      def restart
        invoke Stop
        invoke Start
      end
    end
  end
end
  