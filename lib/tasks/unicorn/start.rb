module Rsm
  module Unicorn
    class Start < Rsm::Base

      def unicorn_rails
        run_ruby_binary "unicorn_rails -D -E #{options[:environment]} -c #{application_root.join("config", "unicorn.rb")}"
      end

    end
  end
end