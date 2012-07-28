#!/usr/bin/env ruby
### define.rb
### Equivalent of 'veewee fusion define'
### Instead of a template in veewee/templates,
### we use origami & seeds

module Seisan
  def define(name)
    distro, version, arch, type, family = Origami.resolve(name)
    destination = File.join(definitions_path, family, distro, version + '.x', arch, type)
    Origami.build_from_seed(name,'kickstart',destination)
    puts
    Origami.build_from_seed(name,'definition',destination)
    puts
    link_definition(name,destination)
    rename_definition(name,destination)
  end

  ## helpers for Seisan#define
  ## helper1: link_definition
  ## Creates a symlink to the target directory in veewee's definition path.
  ## This makes the created definition readily available for build.
  def link_definition(name,dir)
    puts "definition.rb and kickstart file are created."
    puts "Creating a symlink to #{dir} in veewee's definitions directory: #{veewee_definitions}"
    symlink_points_to = File.join(veewee_definitions, name)
    unless File.symlink?(symlink_points_to)
      File.symlink(dir,symlink_points_to)
    else
      puts "symlink already exists. Not overwriting it"
    end
  end

  ## helper2: rename_definition
  ## copies <name>_definition.rb to definition.rb within
  ## the same directory. This allows veewee to find
  ## the definition file.
  def rename_definition(name,dir)
    definition = File.new(File.join(dir, 'definition.rb'),'w')
    old_file = File.new(File.join(dir, name + '_definition.rb'),'r')
    definition.write(old_file.read)
  end
end
