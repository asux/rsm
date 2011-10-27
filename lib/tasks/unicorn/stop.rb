module Rsm
  module Unicorn
    class Stop < Rsm::Base

      def unicorn_rails
        inside "." do
          run "kill $(cat tmp/pids/unicorn.#{options[:environment]}.pid)"
        end
      end

    end
  end
end