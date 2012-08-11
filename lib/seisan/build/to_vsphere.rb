### to_vsphere.rb
### Take a VM created by veewee, turn it off, and export it to
### vSphere using the ovftool.
### ovftool syntax:
### ovftool <4 options> <vmx_file> vi://<user>:<passwd>@<datacenter>/host/<cluster>/Resources/<pool>
### <datacenter> = 'vsphere.dc1.puppetlabs.net/dc1'
### <cluster> = 'c01'
### <pool> = 'AcceptanceTest'

module Seisan
  def vsphere_password
    return 'wzzbyCH5iOcora59D0XE'
  end
  def send_vm(name)
    puts "Exporting #{name} to vSphere..."

    target_vmx = File.join(vm_path, name + '.vmwarevm', name + '.vmx')

    ovf_command = 'ovftool '
    options = []
    options << '--diskMode=thin'
    options << '--vmFolder=AcceptanceTest'
    options << '--network=acceptancetest'
    options << '--datastore=hod'
    ovf_command = ovf_command + options * ' '

    username = nil
    begin
      username = vsphere_username
    rescue
      puts "Enter username"
      username = gets.strip
    end
    passwd = nil
    begin
      passwd = vsphere_password
    rescue
      passwd = Password.get('vSphere password: ')
    end
    datacenter = datacenter_name
    cluster = cluster_name
    resource_pool = resourcepool_name

    vi_path = 'vi://' + username + ':' + passwd + '@' + File.join(datacenter_name, 'host', cluster_name, 'Resources', resourcepool_name)

    command = [ovf_command, target_vmx, vi_path] * ' '

    if system(command)
      puts "Done!"
    end
  end

  def check_vm_status(name)
    puts "Checking if #{name} is running."
    require 'rubygems'
    require 'fission'
    fission_status = Fission::Command::Status.new
    return fission_status.execute['name'] == 'running'
  end
  
  def stop_vm(name)
    if check_vm_status(name)
      puts "#{name} is currently running."
      puts "Stopping #{name}..."
      fission_stop = Fission::Command::Stop.new(args=[name])
      fission_stop.execute
    end
    puts "#{name} has been stopped."
  end
end#Module
