### rename.rb
### helper for define.rb
## copies <name>_definition.rb to definition.rb within
## the same directory. This allows veewee to find
## the definition file.
module Seisan
  def rename_definition(name,dir)
    definition = File.new(File.join(dir, 'definition.rb'),'w')
    old_file = File.new(File.join(dir, name + '_definition.rb'),'r')
    definition.write(old_file.read)
  end
  ## rename the kickstart file to ks.cfg
  def rename_ks(name,dir)
    definition = File.new(File.join(dir, 'ks.cfg'),'w')
    old_file = File.new(File.join(dir, name + '_ks.cfg'),'r')
    definition.write(old_file.read)
  end
end
