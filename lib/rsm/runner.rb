require 'thor'
require 'thor/group'
require 'thor/util'

module Rsm
  class Error < Thor::Error; end
  
  class Runner < Thor
    map '-T' => :list, '-v' => :version
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        #
    include Thor::Actions

    desc "version", "RSM gem version"
    def version
      require 'rsm/version'
      say "RSM version #{Rsm::VERSION}"
    end

    # If a task is not found on Thor::Runner, method missing is invoked and
    # Thor::Runner is then responsable for finding the task in all classes.
    #
    def method_missing(meth, *args)
      meth = meth.to_s
      initialize_thorfiles(meth)
      klass, task = Thor::Util.find_class_and_task_by_namespace(meth)
      args.unshift(task) if task
      klass.start(args, :shell => self.shell)
    end
    
    desc "list [SEARCH]", "List the available thor tasks (--substring means .*SEARCH)"
    method_options :substring => :boolean, :group => :string, :all => :boolean, :debug => :boolean
    def list(search="")
      initialize_thorfiles
  
      search = ".*#{search}" if options["substring"]
      search = /^#{search}.*/i
      group  = options[:group] || "standard"
  
      klasses = Thor::Base.subclasses.select do |k|
        (options[:all] || k.group == group) && k.namespace =~ search
      end
  
      display_klasses(false, false, klasses)
    end
    
    # Override Thor#help so it can give information about any class and any method.
    #
    def help(meth = nil)
      if meth && !self.respond_to?(meth)
        initialize_thorfiles(meth)
        klass, task = Thor::Util.find_class_and_task_by_namespace(meth)
        klass.start(["-h", task].compact, :shell => self.shell)
      else
        super
      end
    end

    private

    def self.banner(task, all = false, subcommand = false)
      "rsm " + task.formatted_usage(self, all, subcommand)
    end
    
    def thor_root
      File.expand_path("../../tasks", __FILE__)
    end
    
    def thorfiles(relevant_to=nil, skip_lookup=false)
      Dir["#{thor_root}/**/*.rb"]
    end
    
    # Load the thorfiles. If relevant_to is supplied, looks for specific files
    # in the thor_root instead of loading them all.
    #
    # By default, it also traverses the current path until find Thor files, as
    # described in thorfiles. This look up can be skipped by suppliying
    # skip_lookup true.
    #
    def initialize_thorfiles(relevant_to=nil, skip_lookup=false)
      thorfiles(relevant_to, skip_lookup).each do |f|
        require f unless Thor::Base.subclass_files.keys.include?(File.expand_path(f))
      end
    end
    
    # Display information about the given klasses. If with_module is given,
    # it shows a table with information extracted from the yaml file.
    #
    def display_klasses(with_modules=false, show_internal=false, klasses=Thor::Base.subclasses)
      klasses -= [Thor, Thor::Group, Rsm::Runner, Rsm::Base] unless show_internal

      raise Error, "No Thor tasks available" if klasses.empty?
      # show_modules if with_modules && !thor_yaml.empty?

      list = Hash.new { |h,k| h[k] = [] }
      groups = klasses.select { |k| k.ancestors.include?(Thor::Group) }

      # Get classes which inherit from Thor
      (klasses - groups).each { |k| list[k.namespace.split(":").first] += k.printable_tasks(false) }

      # Get classes which inherit from Thor::Base
      groups.map! { |k| k.printable_tasks(false).first }
      list["root"] = groups

      # Order namespaces with default coming first
      list = list.sort{ |a,b| a[0].sub(/^default/, '') <=> b[0].sub(/^default/, '') }
      list.each { |n, tasks| display_tasks(n, tasks) unless tasks.empty? }
    end

    def display_tasks(namespace, list) #:nodoc:
      list.sort!{ |a,b| a[0] <=> b[0] }

      say shell.set_color(namespace, :blue, true)
      say "-" * namespace.size

      print_table(list, :truncate => true)
      say
    end

    def show_modules #:nodoc:
      info  = []
      labels = ["Modules", "Namespaces"]

      info << labels
      info << [ "-" * labels[0].size, "-" * labels[1].size ]

      thor_yaml.each do |name, hash|
        info << [ name, hash[:namespaces].join(", ") ]
      end

      print_table info
      say ""
    end
  end
end