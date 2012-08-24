require 'optparse'

module Seisan
  class Options
    attr_reader :options

    def self.parse_args

      @options = {}
      optparse = OptionParser.new do |opts|
        opts.banner = 
        "
        Usage: seisan [--file FILE | --name NAME] [ACTION]* [OPTION]*
       -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
        Specify a NAME or a list of NAMEs in a FILE, act on those with ACTIONs.
        '--name' flag takes only one NAME as an argument.
        To act on more than one NAMEs, use the '--file' flag.
        "

        @options[:name] = nil
        opts.on('-n','--name NAME', "NAME must have the following format: '<distro>-<version>-<arch>-<type>'.") do |name|
          @options[:name] = name
        end

        @options[:file] = nil
        opts.on('-f','--file FILE', "Use all names in a file. One name per line!") do |file|
          @options[:file] = file
        end

        @options[:build] = false
        opts.on('-b','--build',"(action) Build a VMware virtual mahcine.") do
          @options[:build] = true
        end

        @options[:vbox] = false
        opts.on('--vbox',"(build option) Build a virtualbox instead.") do
          @options[:vbox] = true
        end

        @options[:headless] = true
        opts.on('-g','--gui',"(build option) Launch Fusion GUI while installation.") do
          @options[:headless] = false
        end

        @options[:force] = false
        opts.on('--force',"(build option) Destroy the existing VM of the same name then create.") do
          @options[:force] = true
        end

        @options[:bootstrap] = false
        opts.on('-d','--define','--bootstrap', "(action): Create a definition for VM.") do
          @options[:bootstrap] = true
        end

        @options[:vsphere] = false
        opts.on('-v','--vsphere',"(action): Ask vSphere to import an existing VM.") do
          @options[:vsphere] = true
        end

        @options[:templatize] = false
        opts.on('-t','--templatize',"(action): Mark a VM in vSphere as a template.") do
          @options[:templatize] = true
        end

        @options[:destroy] = false
        opts.on('--destroy',"(action) Destroy a VM.") do 
          @options[:destroy] = true
        end

        @options[:list] = false
        opts.on('-l','--list',"(action) List available VMs.") do
          @options[:list] = true
        end

        opts.on('-h','--help','show help') do
          puts opts
          puts
          exit
        end
      end

      optparse.parse!

      return @options
    end

    def self.check_actions(options)
      if options[:name] == nil and options[:file] == nil
        abort("No name chosen. Please use the -n or -f flag to choose which template(s) to work with.")
      end 

      if options[:name] != nil and options[:file] != nil
        abort("Ambiguous options. Both name and file flags are in use.")
      end

      actions =  options[:build], options[:destroy], options[:list]
      check = actions.delete_if {|bool| !bool}
      if check.length > 1
        abort "You can't choose more than one actions."
      end
      if check.length == 0
        abort "No action selected."
      end
    end
    # 
    # temporarily commenting out these.
    #     def self.check_build_options(options)
    #       if options[:templatize]
    #         unless options[:vsphere]
    #           abort("You cannot mark a VM as a template unless it is exported: use --vsphere flag.")
    #         end
    #       end
    #     end
    # 

  end#Class


end#Module
