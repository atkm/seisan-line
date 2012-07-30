### transfer_postscripts.rb
### helper for define.rb
### Transfer postscripts required to the definitions directory
### Postscripts are stored in seisan-line/post_scripts

module Seisan
  def transfer_postscripts(name,destination)
    puts "Preparing to copy postscripts from: " + postscripts_path + '.'
    scripts = Origami.get_value(name,'definition','postinstall_files')
    # calling a function defined in origami. See seed_builder.rb
    puts "Post-scripts required are: "
    puts scripts
    puts "(As defined in origami/lib/definition/seeds/postinstall_files.yml)."
    puts "Transfering post-scripts to #{destination}."
    scripts.each do |sh|
      print( sh + '... ' )
      from = File.join( postscripts_path, sh)
      if system("cp #{from} #{destination}")
        puts 'Done.'
      end
    end
    puts "Post-script transfer completed."
  end

end#Module
