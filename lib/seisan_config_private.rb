### seisan_config_private.rb
### Configs just for internal use

module Seisan

  def project_root
    root = File.expand_path(
                            File.join(File.dirname(__FILE__), '..')
                            )
    return root
  end

  def origami_path
    return File.join( project_root, 'origami/lib')
  end
  
  def veewee_path
    return File.join( project_root, 'veewee')
  end
  def veewee_definitions
    return File.join(project_root, 'veewee/definitions')
  end
  def veewee_command # a shell command
    return "cd #{veewee_path} && bundle exec veewee fusion "
  end

  def definitions_path
    return File.join( project_root, 'definitions')
  end
  def postscripts_path
    return File.join(project_root, 'post_scripts')
  end

 
end
