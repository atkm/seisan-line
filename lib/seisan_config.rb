### seisan_config.rb: config file for seisan.rb
### maybe integrate all config files here
### or just call each config files of
### submodules from here

### Important config files:
###    veewee/lib/veewee/config/ostypes.yml
###    origami/lib/[kickstart,definition]/seeds
###    origami/lib/config.rb
###    origami/lib/[kickstart,definition]/[definition,ks]_base.rb

module Seisan
  def ks_file_server # where ks.cfg is fetched from during installation
    return 'http://192.168.100.225'
  end

  def ks_file_server_local # Somewhere local you can cp ks.cfg to
    return '/Library/WebServer/Documents'
  end

  def vm_path
    require 'yaml'
    return YAML.load_file(File.expand_path('~/.fissionrc'))['vm_dir']
  end

  def ovftool_path
    return File.expand_path('~/Code/ovftools/ovftool')
  end
  
  def vsphere_username
    return 'atsuya'
  end
 
  def datacenter_name
    return 'vsphere.dc1.puppetlabs.net/dc1'
  end

  def cluster_name
    return 'c01'
  end

  def resourcepool_name
    return 'AcceptanceTest'
  end
  
end
