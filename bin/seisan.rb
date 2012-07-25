#!/usr/bin/env ruby
### seisan.rb
### Author: Atsuya Kumano
### July 2012
### *** I wrote these comments before coding so
### *** there may be things that aren't implemented
###
###                    Usage: seisan.rb <COMMAND>
### COMMANDS:
### list box: list all fusion boxes
### list definition: list all pairs of definition.rb and ks.cfg ready for use
### showdir <name>: show the directories which contain
###                   1. VM with name <name>
###                   2. definition.rb and ks.cfg that <name> uses
### define <name>: build definition.rb and ks.cfg for <name>
### define <name> --definition: just definition.rb
### define <name> --kickstart: just ks.cfg
### build <name>: build a <name> fusion box
### build <name> --headless: without GUI
### --help: show help
