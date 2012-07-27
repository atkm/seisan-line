#!/usr/bin/env ruby
### seisan.rb
### Author: Atsuya Kumano
### July 2012
### *** I wrote these comments before coding so
### *** there may be things that aren't implemented
###
###                    Usage: seisan.rb <COMMAND>
### COMMANDS:
### list box: list all fusion boxes
### list definition: list all pairs of definition.rb and ks.cfg ready for use
### showdir <name>: show the directories which contain
###                   1. VM with name <name>
###                   2. definition.rb and ks.cfg that <name> uses
### define <name>: build definition.rb and ks.cfg for <name>
### define <name> --definition: just definition.rb
### define <name> --kickstart: just ks.cfg
### build <name>: build a <name> fusion box
### build <name> --headless: without GUI
### --help: show help

if ARGV.empty?
  puts 'do: --help'
end

project_root = File.expand_path(
                                File.join(File.dirname(__FILE__), '..')
                                )

project_path = File.join( project_root, 'lib')
origami_path = File.join( project_root, 'origami/bin')
$veewee_path = File.join( project_root, 'veewee')
definitions_path = File.join( project_root, 'definitions')

$LOAD_PATH.unshift(project_path) unless $LOAD_PATH.include?(project_path)
$LOAD_PATH.unshift(origami_path) unless $LOAD_PATH.include?(origami_path)

require 'optparse'
require 'optparsing'
require 'origami'

def build(name,options)
  command = "cd #{$veewee_path} && bundle exec veewee fusion build "
  if options[:headless]
    command = command + '-n '
  end
  if options[:force]
    command = command + '-f '
  end
  system(command + name)
end

options = SeisanLine::Options.parse_args

## calling 'veewee build'
## I'm not going to figure out how 'Thor' parses options
## hence, using system call.
if options[:build]
  name = options[:name]
  puts "Initiating the build of #{name}..."
  puts "Options are: "
  puts "\t headless => #{options[:headless]}; force => #{options[:force]}."
  build(name,options)
end


## call 'origami <name>' 
if options[:define]
  build_from_seed(options[:name],'kickstart',definitions_path)
  puts
  build_from_seed(options[:name],'definition',definitions_path)
  puts
end
