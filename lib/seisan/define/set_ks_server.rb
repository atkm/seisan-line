### set_ks_server.rb
### Modify definition.rb to have it use a user-defined
### server from which kickstart file is fetched

module Seisan
  def set_ks_server(definition_file, server_addr)
    server_addr = format_ks_path(server_addr)
    lines = File.new(definition_file, 'r').readlines
    post_replacement = lines.collect do |line|
      if line.include?('boot_cmd_sequence') and line.include?('%%SERVER%%')
        line.gsub('%%SERVER%%',server_addr)
      else
        line
      end
    end
    # overwrite the definition
    File.open(definition_file,'w') do |file|
      post_replacement.each do |line|
        file.puts line
      end
    end
  end
  
  def format_ks_path(path)
    path = path.strip
    test = path.split('/')
    if test[-1] == 'ks.cfg'
      list[0..-2] * '/'
    else
      path
    end
  end
end

if __FILE__==$0
  module Seisan
    extend self
  end
  definition_file = File.expand_path('~/Code/otherstuff/ERB/ipreplacement/test_definition.rb')
  server_addr = ks_file_server
  result = Origami.set_ks_server(definition_file, server_addr)
  puts result
end
