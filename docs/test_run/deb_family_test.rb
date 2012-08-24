#!/usr/bin/ruby
### Tests all distros of Deb family
### Test 1: origami--definition.rb and kickstart created?
### Test 2: veewee--can veewee find those definitions

## one small tweak from the current:
## copy the kickstart file created in the directory to the webserver of the local machine

require 'yaml'


def test_deb(array)
  project_root = File.expand_path("~/Code/seisan-line")
  veewee_definitions = File.join( project_root, '/veewee/definitions')
  webserver = "/Library/WebServer/Documents"
  Dir.chdir(project_root)

  log = File.new(File.join( project_root, 'bin/test.log'),'w')
  
  array.each do |name|
    definition_dir = File.join(veewee_definitions,name)
    definition_file = File.join(definition_dir,'definition.rb')
    preseed_file = File.join(definition_dir, 'preseed.cfg')
    
    # origami
    if system("bin/seisan -d #{name}")
      #cp products to webserver
      if system("cp #{definition_file} #{webserver}")
        if system("cp #{preseed_file} #{webserver}")
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
      puts "#{name} success!"
    else
      log.write("#{name}: definition parsing fail.")
    end#last if
  end#Block
end

if __FILE__ == $0
  if ARGV.length != 1
    abort("Need one input file!")
  end
  test_list = YAML.load_file(ARGV[0])
  test_deb(test_list)
end
