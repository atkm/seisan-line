### link_definition.rb
## helper for define.rb
## Creates a symlink to the target directory in veewee's definition path.
## This makes the created definition readily available for build.
module Seisan
  def link_definition(name,dir)
    puts "definition.rb and kickstart file are created."
    puts "Creating a symlink to #{dir} in veewee's definitions directory: #{veewee_definitions}"
    symlink_points_to = File.join(veewee_definitions, name)
    unless File.symlink?(symlink_points_to)
      File.symlink(dir,symlink_points_to)
    else
      puts "symlink already exists. Not overwriting it"
    end
  end
end
