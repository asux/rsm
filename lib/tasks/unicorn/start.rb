module Rsm
  module Unicorn
    class Start < Rsm::Base
      class_option :environment, :aliases => "-e", :default => "production"
  
      def unicorn_rails
        rvmrc = application_root.join(".rvmrc")
        if rvmrc.exist?
          ruby_cmd = File.new(rvmrc).readline.strip + " exec"
        else
          ruby_cmd = "#{Thor::Util.ruby_command} -S"
        end
        run "#{ruby_cmd} unicorn_rails -D -E #{options[:environment]} -c #{application_root.join("config", "unicorn.rb")}"
      end
      
    end
  end
end