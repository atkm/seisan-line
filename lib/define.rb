#!/usr/bin/env ruby
### define.rb
### Equivalent of 'veewee fusion define'
### Instead of a template in veewee/templates,
### we use origami & seeds

module Seisan
  def define(name)
    Origami.build_from_seed(name,'kickstart',definitions_path)
    puts
    Origami.build_from_seed(name,'definition',definitions_path)
    puts
  end
end
