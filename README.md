# seisan-line #
_'seisan'_ == 'production'.to\_japanese; therefore _'seisan-line'_ == 'production-line'.to\_japanese

Components of _seisan-line_ = veewee + origami + puppet:

- veewee = creates Fusion box based on `definition.rb` and kickstart file--`ks.cfg`.
- origami = creates `definition.rb` and `ks.cfg`.
- puppet = manages veewee and origami && send products to the right places

## Installation ##
Dependencies:

- VMFusion & fission
- rvm
- ruby >= 1.8.7

Procedure:

    git clone git://github.com/akumano/seisan-line.git
	cd seisan-line
	git submodule init   # 'origami' and 'veewee' are used as submodules
	git submodule update
	# The lines below set up veewee.
	cd veewee
	gem install bundler
	bundle install
	# veewee installation complete.
	# 
	mkdir seisan-line/veewee/iso # put your isoimages here
	                             # change seisan-line/origami/definitions/seeds/iso_file.yml accordingly
	mkdir seisan-line/veewee/definitions # this is where veewee looks up when creating VMs
	# The end.

Commands:

- `-d NAME` = `--define NAME` = Create a definition. See options below.  
Take a look at `definition.rb` and `ks.cfg` in a directory corresponding to `NAME` in
`seisan-line/veewee/definitons`, or equivalently, `seisan-line/definitions/(you need to go a bit deep down)`.
- `-b NAME` = `--build NAME` = Build a VM. You need to run `--define` prior to building.
Also see options below.
- `--destroy NAME` = Destroy an existing VM.
- `--list

Options for 'build':

- --force = force creation of VM (i.e. destroy the pre-existing one)
- -g or --gui = launch up 

Example:

    seisan -d 

