module Rsm
  module Unicorn
    class Start < Rsm::Base
      class_option :environment, :aliases => "-e", :default => "production"

      def unicorn_rails
        run_ruby_binary "unicorn_rails -D -E #{options[:environment]} -c #{application_root.join("config", "unicorn.rb")}"
      end

    end
  end
end