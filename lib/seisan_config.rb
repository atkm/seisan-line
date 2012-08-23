### seisan_config.rb: config file for seisan.rb
### maybe integrate all config files here
### or just call each config files of
### submodules from here

### Important config files:
###    veewee/lib/veewee/config/ostypes.yml
###    origami/lib/[kickstart,definition]/seeds
###    origami/lib/config.rb
###    origami/lib/[kickstart,definition]/[definition,ks]_base.rb
require 'yaml'

module Seisan
  def seisanrc
    return YAML.load_file(File.expand_path('~/.seisanrc.yml'))
  end
  def ks_file_server # where ks.cfg is fetched from during installation
    return seisanrc['ks_file_server']
  end

  def ks_file_server_local # Somewhere local you can cp ks.cfg to
    return seisanrc['ks_file_server_local']
  end

  def vm_path
    require 'yaml'
    return YAML.load_file(File.expand_path('~/.fissionrc'))['vm_dir']
  end

  def ovftool_path
    return File.expand_path('~/Code/ovftools/ovftool')
  end
  
  def vsphere_username
    return seisanrc['vsphere_username']
  end
 
  def vsphere_password
    return seisanrc['vsphere_password']
  end

  def host_name
    return seisanrc['host_name']
  end
  def datacenter_name
    return seisanrc['datacenter_name']
  end

  def cluster_name
    return seisanrc['cluster_name']
  end

  def resourcepool_name
    return seisanrc['resourcepool_name']
  end
  
end
