#/usr/bin/env ruby

require 'config'
require 'optparse'
require 'optparsing'
require 'origami'
require 'build'
require 'define'

module SeisanLine
  
  options = Options.parse_args

  ## calling 'veewee build'
  ## I'm not going to figure out how 'Thor' parses options
  ## hence, using system call.
  if options[:build]
    name = options[:name]
    puts "Initiating the build of #{name}..."
    puts "Options selected are: "
    puts "\t headless => #{options[:headless]}; force => #{options[:force]}."
    puts "Passing the work to veewee..."
    build(name,options,veewee_path)
  end


  ## call 'origami <name>' 
  if options[:define]
    puts "Defining #{options[:name]}..."
  end
  
end#Module
