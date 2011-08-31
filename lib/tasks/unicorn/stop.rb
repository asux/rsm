module Rsm
  module Unicorn
    class Stop < Rsm::Base
  
      def unicorn_rails
        pidfile = application_root.join("tmp", "pids", "unicorn.pid")
        run "kill $(cat #{pidfile})"
      end
      
    end
  end
end