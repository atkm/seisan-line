#!/usr/bin/env ruby
### define.rb
### Equivalent of 'veewee fusion define'
### Instead of a template in veewee/templates,
### we use origami & seeds

module SeisanLine
  def define
    build_from_seed(options[:name],'kickstart',definitions_path)
    puts
    build_from_seed(options[:name],'definition',definitions_path)
    puts
  end
