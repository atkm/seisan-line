### build.rb
### builds a VM using veewee

module Seisan
  def build(name,options,veewee_path)
    puts "Initiating the build of #{name}..."
    puts "Options selected are: "
    puts "\t headless => #{options[:headless]}; force => #{options[:force]}."
    print("Passing the work to veewee...\n\n")

    command = veewee_command + 'build '
    if options[:headless]
      command = command + '-n '
    end
    if options[:force]
      command = command + '-f '
    end
    if system(command + name)
      puts "#{name} successfully created."
    end
  end
end
