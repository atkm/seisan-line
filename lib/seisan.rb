#/usr/bin/env ruby

require 'seisan_config'
require 'seisan_config_private'
require 'optparsing'

module Seisan
  extend self

  def seisan(options)
    names = []
    if options[:file] != nil
      names = File.new(options[:file],'r').readlines
      names = names.collect {|name| name.strip}
    else
      names << options[:name]
    end

    if options[:destroy]
      require 'seisan/destroy'
      names.each do |name|
        destroy(name)
      end
    end

    if options[:list]
      require 'seisan/list_definitions'
      list_definitions
    end

    ## A long block to go through the specified actions for each name.
    begin
    names.each do |name|

      ## call 'origami <name>' 
      if options[:define] or options[:bootstrap]
        $LOAD_PATH.unshift(origami_path) unless $LOAD_PATH.include?(origami_path)
        require 'origami'
        require 'seisan/define'
        define(name)
        $LOAD_PATH.shift # remove origami path from LOAD_PATH
      end

      ## calling 'veewee build'
      ## just using system call.
      if options[:build]
        require 'seisan/build'
        build(name,options,veewee_path)
      end

      if options[:vsphere]
        require 'seisan/export_to_vsphere'
        export_to_vsphere(name)
      end

      if options[:templatize]
        require 'seisan/templatize'
        templatize(name)
      end

    end#block
    rescue Interrupt
      puts "Interrupted. Exiting."
    rescue Exception => e
      puts e
    end
  end#def
end#Module
