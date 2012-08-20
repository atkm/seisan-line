# seisan-line #
_'seisan'_ == 'production'.to\_japanese; therefore _'seisan-line'_ == 'production-line'.to\_japanese

Components of _seisan-line_ = veewee + origami + puppet:

- veewee = creates Fusion box based on `definition.rb` and kickstart file--`ks.cfg`.
- origami = creates `definition.rb` and `ks.cfg`.
- puppet = manages veewee and origami && send products to the right places

__Note!__(As of July 31st, 2012): All EL distros (5.x and 6.x) are supported. Debian 6, Ubuntu 10.04/12.04, and SLES 11 will eventually be added to the list.
Currently, `origami` does not support these distros. In the meanwhile, veewee does successfully build them with `definition.rb` and `preseed.cfg`/`autoyast.xml` provided.

## Installation ##
Dependencies:

- VMFusion
- ruby >= 1.8.7
- fission (for stopping vm, which is required for exporting a vm to vSphere)
- rbvmomi (for marking the exported vm a template)

Procedure:

    git clone git://github.com/akumano/seisan-line.git
	cd seisan-line
	git submodule init   # 'origami' and 'veewee' are used as submodules
	git submodule update
	# The lines below set up veewee.
	cd veewee
	gem install bundler
	bundle install # This gets all necessary gems.
	cp seisan-line/veewee/fissionrc.example ~/.fissionrc # Then edit this file. Read comments.
	mkdir seisan-line/veewee/iso # put your isoimages here
	                             # change seisan-line/origami/definitions/seeds/iso_file.yml accordingly
	# veewee is now ready to go.
	# A next thing to do is setting up environment to create definition.rb and ks.cfg,
	  which origami takes care of.
	# Take a look at seisan-line/origami/lib/[kickstart,definition]/seeds/*.yml and change installation options.
	# The format is fairly straight forward. Read origami's documentation if you'd like.
	# The end.

## Usage ##

Example: Cook up CentOS-5-32-typeA Fusion box.

1. Create definition for veewee: `seisan --define CentOS-5-32-typeA`
2. Let veewee create the box: `seisan --build CentOS-5-32-typeA`
3. Provision it via fission.
4. That's it.

Commands:

- `-d NAME` = `--define NAME` = Create a definition. See options below.  
Take a look at `definition.rb` and `ks.cfg` in a directory corresponding to `NAME` in
`seisan-line/veewee/definitons`, or equivalently, `seisan-line/definitions/(you need to go a bit deep down)`.
- `-b NAME` = `--build NAME` = Build a VM. You need to run `--define` prior to building.
Also see options below.
- `--destroy NAME` = Destroy an existing VM.
- `--list` = List already defined boxes.

Options for 'build':

- --force = force creation of VM (i.e. destroy the pre-existing one)
- -g or --gui = launch up VMFusion GUI

__NAME format__:  
`NAME` must meet the following format: `<distro>-<version>-<arch>-<type>`, where the ones supported by default are:

- `distro` <- ['CentOS', 'RedHat', 'SL', 'Oracle', 'Ubuntu', 'Debian', 'SLES']
- `version` <- (for EL) ['5', '6'] / (for Ubuntu) ['10', '12'] / (for Debian) ['6'] / (for SLES) ['11']
- `arch` <- ['32', '64']
- `type` <- ['typeA', 'typeB']

You should rename 'typeA' and/or 'typeB' directory as well as corresponding entries in `seeds/*.yml` to something that makes sense for your purpose. See the 'How to' section to expand the list above.

_A note on veewee:_
`seisan-line` only uses 'build' and 'destroy' commands of veewee. I believe this is sufficient. (I don't even need 'destroy' really, as fission can take care of it.) 
`seisan-line` uses `veewee` via system call, so in case you want to use some other veewee commands from `seisan-line`, take a terse look at `build.rb` or `destroy.rb` and implement it.

## How to: ##
### Change installation options (existing type (EL)) ###
>	Take a look at seisan-line/origami/lib/[kickstart,definition]/seeds/*.yml and change installation options.
>	The format is fairly straight forward. Read origami's documentation if you'd like.  
[origami documentation](seisan-line/origami/README.md)

Note that you can only change the following options by this method: `pkgs`, `kickstart_file`, `iso_file`, `os_type_id`, `iso_file`, `boot_cmd_sequence`, `postinstall_files`, and `reponame`.
Other options are shared among all installations.
To change these guys, see 'Change pre-defined installation options'

### Add a new type of an existing distro ###
The only way to do this currently is to manually a new key-value pairs in each seeds/*.yml file. A better method coming up soon!

### Add new OS ###
First, you need to manually create corresponding directories in `seisan-line/definitions`. Then you need to deal with the origami code. As in 'adding a new type of an existing distro', the process is tedious. This code needs to be more scalable.
[See origami](seisan-line/origami/README.md)

### Change pre-defined (i.e. internally fixed) installation options (such as `network`, `firewall`, and so on) ###
For anaconda-based installation (EL), these are:
(Kickstart:)`install_option,`, `lang`, `keyboard`, `network`, `rootpw`, `firewall`, `authconfig`, `selinux`, `timezone`, `bootloader`, `skipx`, `partition`, `power_option`, `baseurl`, (veewee-definition:)`cpu_count`, `memory_size`, `disk_size`, `disk_format`, `hostiocache`, `ioapic`, `pae`, `iso_src`, `iso_md5`, `iso_download_timeout`, `boot_wait`, `kickstart_port`, `kickstart_timeout`, `ssh_login_timeout`, `ssh_user`, `ssh_password`, `ssh_key`, `ssh_host_port`, `ssh_guest_port`, `sudo_cmd`, `shutdown_cmd`, `postinstall_timeout`.

There are a LOT more options for kickstart file, although these were what I needed for successful deployment of VM by veewee. See [Fedora's kickstart guide](http://fedoraproject.org/wiki/Anaconda/Kickstart) if you need more options.

(These options are deliberately made less mobile because they do not differentiate product VMs by much. The less options you need to tweak, the less yaml files you have to maintain.)  

These options are defined in `ks_base.rb` and `definition_base.rb` under `origami/lib/[kickstart,definition]`.

