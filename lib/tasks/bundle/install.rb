module Rsm
  module Bundle
    class Install < Rsm::Base
      class_option :deployment, :aliases => "-D", :type => :boolean, :default => false, :desc => "Use deployment mode"

      def check_and_install
        bundle_install = "bundle install"
        bundle_install << " --deployment" if options[:deployment]
        inside "." do
          run_ruby_binary "bundle check || #{bundle_install}"
        end
      end

    end
  end
end