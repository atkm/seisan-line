#/usr/bin/env ruby

require 'seisan_line_config'
require 'optparsing'

module Seisan
  extend self

  def seisan(options)
    ## calling 'veewee build'
    ## I'm not going to figure out how 'Thor' parses options
    ## hence, using system call.
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
    
    ## call 'origami <name>' 
    if options[:define]
      $LOAD_PATH.unshift(origami_path) unless $LOAD_PATH.include?(origami_path)
      require 'origami'
      require 'seisan/define'
      name = options[:name]
      define(name)
    end
    
  end#def
end#Module
