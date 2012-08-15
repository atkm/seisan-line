require 'optparse'

module Seisan
  class Options
    attr_reader :options

    def self.parse_args
      
      @options = {}
      optparse = OptionParser.new do |opts|
        opts.banner = "Usage: seisan <command>"
        
        @options[:name] = nil
        opts.on('-n','--name NAME', "NAME must have the following format: '<distro>-<version>-<arch>-<type>'.") do |name|
          @options[:name] = name
        end

        @options[:build] = false
        opts.on('-b','--build',"Build VM.") do
          @options[:build] = true
        end

        @options[:headless] = true
        opts.on('-g','--gui',"build option: Launch Fusion GUI while installation.") do
          @options[:headless] = false
        end

        @options[:force] = false
        opts.on('-f','--force',"build option. Destroy the existing VM of the same name then create.") do
          @options[:force] = true
        end

        @options[:bootstrap] = false
        opts.on('--bootstrap',"build option: Create definition before building.") do
          @options[:bootstrap] = true
        end
        
        @options[:vsphere] = false
        opts.on('-v','--vsphere',"build option: Ask vSphere to import the created VM.") do
          @options[:vsphere] = true
        end
        
        @options[:templatize] = false
        opts.on('-t','--templatize',"build option: Mark the VM exported to vSphere as a template.") do
          @options[:templatize] = true
        end
        
        @options[:define] = false
        opts.on('-d','--define NAME',"Create a VM definition for veewee.") do |name|
          @options[:define] = true
          @options[:name] = name
        end

        @options[:destroy] = false
        opts.on('--destroy NAME',"Destroy a VM") do |name|
          @options[:destroy] = true
          @options[:name] = name
        end

        @options[:list] = false
        opts.on('-l','--list') do
          @options[:list] = true
        end
        
        opts.on('-h','--help','show help') do
          puts opts
          exit
        end
      end

      optparse.parse!
      
      return @options
    end

    def self.check_actions(options)
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
