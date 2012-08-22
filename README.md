# seisan-line #
Easy mass-production of fine-tuned vmware/virtualbox VMs.  
_'seisan'_ == 'production'.to\_japanese; therefore _'seisan-line'_ == 'production-line'.to\_japanese

Components of _seisan-line_ = veewee + origami (+ puppet, eventually):

- veewee = creates Fusion box based on `definition.rb` and kickstart file--`ks.cfg`.
- origami = creates `definition.rb` and `ks.cfg`.
- (puppet = manages veewee and origami && send products to the right places)

__Note__ (As of Aug 22nd, 2012): EL 5 and 6, Debian 6, Ubuntu 10.04/12.04, and SLES 11 are supported.

## Installation ##
Dependencies:

- VMFusion
- ruby >= 1.8.7
- fission (for stopping vm)
- rbvmomi (for marking the exported vm a template)
- other gems required by veewee

Procedure:

    git clone git://github.com/akumano/seisan-line.git
  	cd seisan-line
    git submodule init   # 'origami' and 'veewee' are used as submodules
    git submodule update # fetch repos as specified in .gitmodule
    gem install fission rbvmomi
    # The lines below set up veewee.
    cd veewee
    gem install bundler
    bundle install # This gets all necessary gems for veewee
    cp seisan-line/veewee/fissionrc.example ~/.fissionrc # Then edit this file. Read comments.
    mkdir seisan-line/veewee/iso # put your isoimages here
	                             # change seisan-line/origami/definitions/seeds/iso_file.yml accordingly
    # veewee is now ready to go.
    # One next thing to do is setting up environment to create definition.rb and ks.cfg,
	  which 'origami' takes care of.
    # Take a look at seisan-line/origami/lib/inventory/[kickstart|preseed|autoinst|definition]/seeds/*.yml and change installation options.
    # The format is fairly straight forward. Read origami's documentation if you'd like.
    # The end.


## Examples ##

Example 1: Create CentOS-5-32-PE definition, inspect it, then build Fusion box.

1. Create definition for veewee: `seisan --name CentOS-5-32-PE --define`
2. See `veewee/definitions/CentOS-5-32-PE/[definition.rb|ks.cfg]`
3. Have veewee create the box w/ gui: `seisan --name CentOS-5-32-PE --build --gui`
4. Veewee will spit out the box's ip address when it finishes building.
    A command to ssh into the box would be

    `ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p <port> -l <user> <ip.address>`  

    (By default, \<user> = root, \<passwd> = puppet)

Example 2: Build all Ubuntu boxes, send it to vSphere and templatize them

1. Create a file `ubuntu_names.txt` containing all Ubuntu names:

        Ubuntu-10-32-PE 
        Ubuntu-10-32-FOSS  
        Ubuntu-10-64-PE  
        Ubuntu-10-64-FOSS
        Ubuntu-12-32-PE
        Ubuntu-12-32-FOSS
        Ubuntu-12-64-PE
        Ubuntu-12-64-FOSS

2. Have 'seisan-line' act on the file:  

        seisan --file ubuntu.txt --build --bootstrap --vsphere --templatize

    For each box it will take just a moment to create definition, 
   5~10 minutes to build a rather bare-bone box,
   0.5~1 hour to export it to vsphere
   and another instant for templatization.


## Usage ##

__Important__:  
SLES network interface name is not persistent. It often changes between eth0 and eth1.
I have even seen eth2 or 3. By default, seisan-line is robust 
enough to support eth0~5 in anticipation of even more outrageous situations.
If ethN, where N>5, ever appears, go into `origami/lib/inventory/autoinst/autoinst_base.erb` edit it to deal with the situation.
Find all locaitons in the config file where eth1 (or eth0) is mentioned,
and create corresponding entries for ethN.

__Commands__:  
(I will use the term `ks.cfg` as a generic configuration file for
unattended installation procedures such as 'anaconda', 'preseed'
and 'autoyast'.)

- `-d`, `--define`, `--bootstrap`:
    - Create a definition for veewee to work on.
    - A definition directory, which contains `definition.rb`, `ks.cfg`, and post-install scripsts, 
      is created under `veewee/definitions`.
    - In addition, `ks.cfg` and `definition.rb` will be copied to the webserver 
      you specified in `seisan_config.rb`.  

- `-b`, `--build`:
    - Build a VM. A definition must exist prior to building.
      Using the `--bootstrap` flag with the build flag will
      create a definition then start building a box.
    - Force option (`--force`): force creation of VM even if a VM of the same
     name exists (i.e. destroy the pre-existing one).
    - GUI option (`-g` or `--gui`): launch up VMFusion GUI while installation
    - VirtualBox option (`--vbox`): make a small change in `definition.rb` to tell veewee to build a VM with virtualbox.

- `--vsphere`:
    - Export a VM to vSphere. `lib/seisan_config.rb` needs to be edited.

- `--templatize`:
    - Mark a VM in vSphere as a template. `lib/seisan_config.rb` needs to be edited to use this flag, as well.


- `--destroy `:
    - Destroy an existing VM.

- `--list`:
    - List boxes that are ready to be built.


__NAME format__:  
`NAME` must meet the following format: `<distro>-<version>-<arch>-<type>`, where the ones supported by default are:

- `distro` -- CentOS, RedHat, SL, Oracle, Ubuntu, Debian, SLES
- `version` -- (EL) 5, 6 ; (Ubuntu) 10, 12 ; (Debian) 6 ; (SLES) 11
- `arch` -- 32, 64
- `type` -- PE, FOSS


## How to: ##
### Change installation options ###
Take a look at `origami/lib/inventory/[kickstart,preseed,autoinst,definition]/seeds/\*.yml`
and change installation options. The format is fairly straight forward.
For example,
    
    # pkgs.yml
    ---
    Oracle:
      '5':
        PE:
        - openssh-server
        FOSS:
        - openssh-server
        - ruby
      '6':
        PE:
        - openssh-server
        - git
        FOSS:
        - openssh-server
        - git
        - ruby

means `Oracle-5-<whatever arch>-PE` will be built with `openssh-server` installed,
`Oracle-6-<whatever>-FOSS` will be built with `openssh-server`, `git` and `ruby` installed, and so on.
        
Read origami's documentation if you'd like > 
http://github.com/akumano/origami/README.md

Note that you can only change the following options by modifying yaml files:
`pkgs`, `kickstart_file`, `iso_file`, `os_type_id`, `iso_file`, `boot_cmd_sequence`, `postinstall_files`, and `reponame`.
Other options are shared among all installations.
To change those options, see 'HowTo: Change pre-defined installation options'

### Add a new type of an existing distro ###
The only way to do this currently is to manually a new key-value pairs in each seeds/\*.yml file. A better method coming up soon.
Also, the directory structure must comply to the naming scheme in use, and
they are __not__ automatically generated. Hence if you wish to create
a new type you need to create new directories under `definitions` (not `veewee/definitions`).
For example, here's [the directory tree of my default](docs/definitions_tree.txt)

### Add new OS ###
First, you need to manually create corresponding directories in `seisan-line/definitions`. Then you need to deal with the origami code. As in 'adding a new type of an existing distro', the process is tedious. This code needs to be more scalable.
See origami: http://github.com/akumano/origami

### Change pre-defined (i.e. internally fixed) installation options (such as `network`, `firewall`, and so on) ###
For anaconda-based installation (EL), these are:
(Kickstart:)`install_option,`, `lang`, `keyboard`, `network`, `rootpw`, `firewall`, `authconfig`, `selinux`, `timezone`, `bootloader`, `skipx`, `partition`, `power_option`, `baseurl`, (veewee-definition:)`cpu_count`, `memory_size`, `disk_size`, `disk_format`, `hostiocache`, `ioapic`, `pae`, `iso_src`, `iso_md5`, `iso_download_timeout`, `boot_wait`, `kickstart_port`, `kickstart_timeout`, `ssh_login_timeout`, `ssh_user`, `ssh_password`, `ssh_key`, `ssh_host_port`, `ssh_guest_port`, `sudo_cmd`, `shutdown_cmd`, `postinstall_timeout`.

Evidently, there are a LOT more options for kickstart file, although these were what I needed for successful deployment of VM. See [Fedora's kickstart guide](http://fedoraproject.org/wiki/Anaconda/Kickstart) if you need to tweak something.

(These options are deliberately made less mobile because they do not differentiate product VMs by much. The less options you need to tweak, the less yaml files you have to maintain.)  

These options are defined in `ks_base.rb` and `definition_base.rb` under `origami/lib/[kickstart,definition]`.

### VirtualBox instead of VMware ###
Use `--vbox` flag with either `--define` or `--bootstrap`. This will change the `disk_format` in `definiton.rb` from 'VMDK' to 'VDI'. Alternatively, you should change the option in `definition_base.erb` if you use VirtualBox primarily.
