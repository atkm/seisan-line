### rename.rb
### helper for define.rb
## copies <name>_definition.rb to definition.rb within
## the same directory. This allows veewee to find
## the definition file.
module Seisan
  require 'fileutils'
  def rename_definition(name,dir)
    definition = File.join(dir, 'definition.rb')
    old_file = File.join(dir, name + '_definition.rb')
    puts "Creating definition.rb in the definition directory..."
    FileUtils.cp(old_file,definition)
    puts "Done."
  end
  ## rename the kickstart file to ks.cfg
  def rename_ks(name,dir)
    ks_file_name = choose_ks_file_name(name)
    kickstart = File.join(dir, ks_file_name)
    old_file = File.join(dir, name + '_' + ks_file_name)
    puts "Creating kickstart file (or preseed or autoinst) in the definition directory..."
    FileUtils.cp(old_file,kickstart)
    puts "Done."
  end
  def choose_ks_file_name(name)
    family = Origami.resolve(name)[4]
    instruction = {'EL' => 'ks.cfg','Deb' => 'preseed.cfg', 'SUSE' => 'autoyast.xml'}
    return instruction[family]
  end
end
