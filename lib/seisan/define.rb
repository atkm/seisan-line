### define.rb
### Equivalent of 'veewee fusion define'
### Instead of a template in veewee/templates,
### we use origami & seeds

Dir[File.dirname(__FILE__) + "/define/*"].each {|helper| require helper}

module Seisan
  def define(name)
    distro, version, arch, type, family = Origami.resolve(name)
    destination = File.join(definitions_path, family, distro, version + '.x', arch, type)
    Origami.build_from_seed(name,'kickstart',destination)
    puts
    Origami.build_from_seed(name,'definition',destination)
    puts
    puts "Defining #{name}..."
    link_definition(name,destination)
    rename_definition(name,destination)
    rename_ks(name,destination)
    transfer_postscripts(name,destination)
  end
end
