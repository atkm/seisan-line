#/usr/bin/env ruby

require 'seisan_line_config'
require 'optparsing'

module Seisan
  extend self

  def seisan(options)

    name = options[:name]

    if options[:destroy]
      require 'seisan/destroy'
      destroy(name)
    end

    if options[:list]
      require 'seisan/list_definitions'
      list_definitions
    end

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


  end#def
end#Module
