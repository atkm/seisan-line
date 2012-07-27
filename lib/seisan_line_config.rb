#!/usr/bin/env ruby
### config.rb: config file for seisan.rb
### maybe integrate all config files here
### or just call each config files of
### submodules from here

### Important config files:
###    veewee/lib/veewee/config/ostypes.yml
###    origami/lib/[kickstart,definition]/seeds
###    origami/lib/config.rb
###    origami/lib/[kickstart,definition]/[definition,ks]_base.rb

module Seisan
  def project_root
    root = File.expand_path(
                            File.join(File.dirname(__FILE__), '..')
                            )
    return root
  end

  def veewee_definitions
    return File.join(project_root, 'veewee/definitions')
  end
  def origami_path
    return File.join( project_root, 'origami/lib')
  end
  def veewee_path
    return File.join( project_root, 'veewee')
  end
  def definitions_path
    return File.join( project_root, 'definitions')
  end
end
