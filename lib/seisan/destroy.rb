### destroy.rb
### Execute 'veewee destroy name'

module Seisan
  def destroy(name)
    puts "Destroy #{name} VM? [Y/n]"
    ans = gets
    if ans == 'Y' or ans == 'y'
      command = veewee_command + 'destroy '
      command << name
      system(command)
    else
      puts "Aborting..."
    end
  end
end
