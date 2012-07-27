require 'optparse'

module Seisan
  class Options
    attr_reader :options

    def self.parse_args
      
      @options = {}
      optparse = OptionParser.new do |opts|
        opts.banner = "Usage: seisan <command>"

        @options[:build] = nil
        @options[:name] = nil
        opts.on('-b','--build NAME',"Define (if definition and kickstart not present) & Build VM.\n#{"\t"*4 + "\s"*5}It is recommended to 'define' and take a look at confing files before 'build'.\n#{"\t"*4 + "\s"*5}NAME must have the following format: '<distro>-<version>-<arch>-<type>'.") do |name|
          @options[:build] = true
          @options[:name] = name
        end
        
        @options[:headless] = true
        opts.on('-g','--gui',"Use with build flag. Launch Fusion GUI.") do
          @options[:headless] = false
        end

        @options[:force] = false
        opts.on('-f','--force',"Use with build flag. Destroy the existing VM of the same name then create.") do
          @options[:force] = true
        end

        @options[:define] = nil
        opts.on('-d','--define NAME') do |name|
          @options[:define] = true
          @options[:name] = name
        end
        
        opts.on('-h','--help','show help') do
          puts opts
          exit
        end
      end

      optparse.parse!

      if @options[:build] and @options[:define]
        puts "\tBoth 'build' and 'define' were chosen."
        abort("\tBad option. You can only choose one action.")
      end
      
      return @options
    end
  end#Class
end#Module
