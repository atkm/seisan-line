#!/usr/bin/ruby
### Tests all distros of EL family
### Test 1: origami--definition.rb and kickstart created?
### Test 2: veewee--can veewee find those definitions

## one small tweak from the current:
## copy the kickstart file created in the directory to the webserver of the local machine

require 'yaml'

test_list = YAML.load_file(ARGV[0])

def test_el(array)
  project_root = File.expand_path("~/Code/seisan-line")
  veewee_definitions = File.join( project_root, '/veewee/definitions')
  webserver = File.expand_path("~/Sites")
  Dir.chdir(project_root)

  log = File.new(File.join( project_root, 'bin/test.log'),'w')
  
  array.each do |name|
    definition_dir = File.join(veewee_definitions,name)
    definition_file = File.join(definition_dir,'definition.rb')
    ks_file = File.join(definition_dir, 'ks.cfg')
    
    # origami
    if system("bin/seisan -d #{name}")
      # cp products to webserver
      if system("cp #{definition_file} #{webserver}")
        if system("cp #{ks_file} #{webserver}")
          # run veewee
          if system("bin/seisan -b #{name} --force --gui")
            log.write("#{name}: build SUCCESS!!")
          else
            log.write("#{name}: veewee build fail.")
          end
        else
          log.write("#{name}: copying to http server fail (kickstart).")
        end
      else
        log.write("#{name}: copying to http server fail (definition).")
      end
    else
      log.write("#{name}: definition parsing fail.")
    end#last if
  end#Block
end

if __FILE__ == $0
  test_el(test_list)
end
