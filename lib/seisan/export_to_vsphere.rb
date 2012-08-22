### to_vsphere.rb
### Take a VM created by veewee, turn it off, and export it to
### vSphere using the ovftool.
### ovftool syntax:
### ovftool <4 options> <vmx_file> vi://<user>:<passwd>@<datacenter>/host/<cluster>/Resources/<pool>
### <datacenter> = 'vsphere.dc1.puppetlabs.net/dc1'
### <cluster> = 'c01'
### <pool> = 'AcceptanceTest'

module Seisan

  def export_to_vsphere(name)
    stop_vm(name)
    send_vm(name)
  end

  def send_vm(name)
    puts "Exporting #{name} to vSphere..."

    target_vmx = File.join(vm_path, name + '.vmwarevm', name + '.vmx')

    args = []
    args << ovftool_path
    args << '--diskMode=thin'
    args << '--vmFolder=AcceptanceTest'
    args << '--network=acceptancetest'
    args << '--datastore=hod'
    args << '--powerOffSource'
    ovf_command = args * ' '

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
    puts "Executing #{command}..."

    if system(command)
      puts "Done!"
    else
      puts "Failed to execute #{command}."
    end
  end

  def check_vm_status(name)
    puts "Checking if #{name} is running."
    require 'rubygems'
    require 'fission'
    fission_status = Fission::Command::Status.new
    if fission_status.execute[name] == 'running'
      return true
    else
      return false
    end
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
