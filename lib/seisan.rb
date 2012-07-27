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
      puts "Passing the work to veewee..."
      build(name,options,veewee_path)
    end


    ## call 'origami <name>' 
    if options[:define]
      require 'origami'
      require 'define'
      puts "Defining #{options[:name]}..."
    end
    
  end#def
end#Module
