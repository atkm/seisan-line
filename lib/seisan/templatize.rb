### templatize.rb
###

require 'rubygems'
require 'rbvmomi'

module Seisan

  def templatize(name)
    puts "Connecting to #{host_name}..."
    vim = RbVmomi::VIM.connect :host => host_name, :user => vsphere_username, :password => vsphere_password, :insecure => true
    puts "Connected with user #{vsphere_username}."
    puts "Looking for #{datacenter_name}..."
    dc = vim.serviceInstance.find_datacenter(datacenter_name) or fail "dc1 not found"
    puts "Found #{datacenter_name}."
    puts "Looking for VM #{name}..."
    vm = dc.find_vm("#{resourcepool_name}/#{name}") or fail "vm not found" 
    puts "Found #{name}. Insuring that its status is 'off'..."
    if vm.summary.runtime.powerState == 'poweredOn'
      puts "#{name} is currently on. Powering off..."
      vm.PowerOffVM_Task.wait_for_completion
      puts "Done."
    end

    begin
      puts "Marking #{name} as template..."
      vm.MarkAsTemplate
      puts "Complete!"
    # What I really want to 'rescue' is NotSupported.
    # A vm in 'poweredOn' state also gives Fault, but of a different kind (InvalidPowerState)
    rescue RbVmomi::Fault
      puts "Something went wrong. Most likely the VM wasn't properly power off or it was already marked as a template."
    end

  end
end
