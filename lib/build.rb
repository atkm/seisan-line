#!/usr/bin/env ruby
### build.rb
### builds a VM using veewee

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
