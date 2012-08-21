### templatize.rb
###

require 'rubygems'
require 'rbvmomi'

module Seisan

  def templatize(name)
    puts "Connecting to vsphere.dc1.puppetlabs.net..."
    vim = RbVmomi::VIM.connect :host => 'vsphere.dc1.puppetlabs.net', :user => 'atsuya', :password => 'wzzbyCH5iOcora59D0XE', :insecure => true
    puts "Connected with user 'atsuya'."
    puts "Looking for dc1..."
    dc = vim.serviceInstance.find_datacenter('dc1') or fail "dc1 not found"
    puts "Found dc1."
    puts "Looking for VM #{name}..."
    vm = dc.find_vm("AcceptanceTest/#{name}") or fail "vm not found" 
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
