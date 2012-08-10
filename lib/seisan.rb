#/usr/bin/env ruby

require 'seisan_line_config'
require 'optparsing'

module Seisan
  extend self

  def seisan(options)

    ## call 'origami <name>' 
    if options[:define] or options[:bootstrap]
      $LOAD_PATH.unshift(origami_path) unless $LOAD_PATH.include?(origami_path)
      require 'origami'
      require 'seisan/define'
      name = options[:name]
      define(name)
      $LOAD_PATH.shift # remove origami path from LOAD_PATH
    end
 
    ## calling 'veewee build'
    ## just using system call.
    if options[:build]
      require 'seisan/build'
      name = options[:name]
      build(name,options,veewee_path)
    end

    if options[:destroy]
      require 'seisan/destroy'
      name = options[:name]
    end

    if options[:list]
      require 'seisan/list_definitions'
      list_definitions
    end
    
   
  end#def
end#Module
