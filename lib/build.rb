#!/usr/bin/env ruby
### build.rb
### builds a VM using veewee
### I don't understand how 'Thor' parses options
### and what arguments veewee objects take
### so just calling veewee from command line

module Seisan
  def build(name,options,veewee_path)
    command = "cd #{veewee_path} && bundle exec veewee fusion build "
    if options[:headless]
      command = command + '-n '
    end
    if options[:force]
      command = command + '-f '
    end
    system(command + name)
  end
end
