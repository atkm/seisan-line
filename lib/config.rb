#!/usr/bin/env ruby
### config.rb: config file for seisan.rb
### maybe integrate all config files here
### or just call each config files of
### submodules from here

module SeisanLine
  
  def project_root
    root = File.expand_path(
                            File.join(File.dirname(__FILE__), '..')
                            )
    return root
  end

  def veewee_definitions
    File.join(project_root, 'veewee/definitions')
  end
  def origami_path
    File.join( project_root, 'origami/bin')
  end
  def veewee_path
    File.join( project_root, 'veewee')
  end
  def definitions_path
    File.join( project_root, 'definitions')
  end
end
