### list_definitions.rb
### respond to 'seisan list'

module Seisan
  def list_definitions
    puts "These are the definitions currently available for build: "
    Dir.foreach(veewee_definitions) do |name|
      if !name.start_with?('.')
        puts name
      end
    end
  end
end#Module
