module Rsm
  module Unicorn
    class Stop < Rsm::Base

      def unicorn_rails
        inside "." do
          run "kill $(cat tmp/pids/unicorn.pid)"
        end
      end

    end
  end
end