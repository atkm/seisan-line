### build.rb
### builds a VM using veewee

module Seisan
  def build(name,options,veewee_path)
    puts "Initiating the build of #{name}..."
    puts "Options selected are: "
    puts "\t headless => #{options[:headless]}; force => #{options[:force]}."
    print("Passing the work to veewee...\n\n")

    command = veewee_command + 'build '
    if options[:bootstrap]
      puts "Bootstrap option was selected."
      $LOAD_PATH.unshift(origami_path) unless $LOAD_PATH.include?(origami_path)
      require 'origami'
      require 'seisan/define'
      name = options[:name]
      define(name)
      puts "Definition for #{name} has been created."
      puts "Now initiating its build."
    end
    if options[:headless]
      command = command + '-n '
    end
    if options[:force]
      command = command + '-f '
    end
    system(command + name)
  end
end
