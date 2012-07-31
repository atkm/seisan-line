# seisan-line #
_'seisan'_ == 'production'.to\_japanese; therefore _'seisan-line'_ == 'production-line'.to\_japanese

Components of _seisan-line_ = veewee + origami + puppet:

- veewee = creates Fusion box based on `definition.rb` and kickstart file--`ks.cfg`.
- origami = creates `definition.rb` and `ks.cfg`.
- puppet = manages veewee and origami && send products to the right places

## Installation ##

Dependencies:

- VMFusion (of course)
- fission

Commands:

- -d or --define
- -b or --build
- --destroy

Options for 'build':

- --force = force creation of VM (i.e. destroy the pre-existing one)
- -g or --gui = launch up 
