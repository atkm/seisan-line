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
    ks_file_name = choose_ks_file_name(name)
    kickstart = File.new(File.join(dir, ks_file_name),'w')
    old_file = File.new(File.join(dir, name + '_' + ks_file_name),'r')
    kickstart.write(old_file.read)
  end
  def choose_ks_file_name(name)
    family = Origami.resolve(name)[4]
    instruction = {'EL' => 'ks.cfg','Deb' => 'preseed.cfg', 'SUSE' => 'autoyast.xml'}
    return instruction[family]
  end
end
