#!/usr/bin/env ruby
### config.rb: config file for seisan.rb
### maybe integrate all config files here
### or just call each config files of
### submodules from here

module SeisanLine
  veewee_definitions = File.join(project_root, 'veewee/definitions')
  origami_path = File.join( project_root, 'origami/bin')
  veewee_path = File.join( project_root, 'veewee')
  definitions_path = File.join( project_root, 'definitions')
end
