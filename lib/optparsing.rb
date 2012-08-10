require 'optparse'

module Seisan
  class Options
    attr_reader :options

    def self.parse_args
      
      @options = {}
      optparse = OptionParser.new do |opts|
        opts.banner = "Usage: seisan <command>"

        @options[:build] = false
        @options[:name] = nil
        opts.on('-b','--build NAME',"Build VM.\n#{"\t"*4 + "\s"*5}It is recommended to 'define' and take a look at confing files before 'build'.\n#{"\t"*4 + "\s"*5}NAME must have the following format: '<distro>-<version>-<arch>-<type>'.") do |name|
          puts "optparse debug #{name}"
          @options[:build] = true
          @options[:name] = name
        end

        @options[:bootstrap] = false
        opts.on('--bootstrap',"Create definition before building.") do
          @options[:bootstrap] = true
        end
        
        @options[:headless] = true
        opts.on('-g','--gui',"Use with build flag. Launch Fusion GUI.") do
          @options[:headless] = false
        end

        @options[:force] = false
        opts.on('-f','--force',"Use with build flag. Destroy the existing VM of the same name then create.") do
          @options[:force] = true
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
      
      actions =  @options[:build], @options[:define], @options[:destroy], @options[:list]

      check = actions.delete_if {|bool| !bool}
      if check.length > 1
        abort "You can't choose more than one actions.\nNote that you can use --bootstrap flag for build to define AND build."
      end
      if check.length == 0
        abort "No action selected."
      end
      
      return @options
    end
  end#Class
end#Module
