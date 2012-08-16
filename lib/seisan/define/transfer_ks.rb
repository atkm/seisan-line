### transfer_ks.rb
### Transfer ks.cfg (or preseed.cfg or autoinst.xml or whatever) to a
### user-defined server to make it available for fetching.

require 'fileutils'

module Seisan
  def transfer_ks(name,server)
    file_name = choose_ks_file_name(name)
    ks_file = File.join(definition_of_name(name), file_name)
    puts "Transfering kickstart file #{ks_file} to #{server}..."
    FileUtils.cp(ks_file, server)
    puts "Done."
  end
end
