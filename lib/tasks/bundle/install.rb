module Rsm
  module Bundle
    class Install < Rsm::Base
      class_option :deployment, :aliases => "-D", :type => :boolean, :default => false, :desc => "Use deployment mode"
      class_option :without, :desc => "Pass to --without bundler's option"

      def check_and_install
        bundle_install = "bundle install"
        bundle_install << " --deployment" if options[:deployment]
        bundle_install << " --without #{options[:without]}" if options[:without]
        inside "." do
          run_ruby_binary "bundle check || #{bundle_install}"
        end
      end

    end
  end
end