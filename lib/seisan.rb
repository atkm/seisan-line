#/usr/bin/env ruby

require 'config'
require 'optparsing'

module Seisan
  extend self

  def seisan(options)
    ## calling 'veewee build'
    ## I'm not going to figure out how 'Thor' parses options
    ## hence, using system call.
    if options[:build]
      require 'build'
      name = options[:name]
      puts "Initiating the build of #{name}..."
      puts "Options selected are: "
      puts "\t headless => #{options[:headless]}; force => #{options[:force]}."
      print("Passing the work to veewee...\n\n")
      build(name,options,veewee_path)
    end


    ## call 'origami <name>' 
    if options[:define]
      $LOAD_PATH.unshift(origami_path) unless $LOAD_PATH.include?(origami_path)
      require 'origami'
      require 'define'
      name = options[:name]
      puts "Defining #{name}..."
      define(name)
    end
    
  end#def
end#Module
