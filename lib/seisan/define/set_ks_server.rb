### set_ks_server.rb
### Modify definition.rb to have it use a user-defined
### server from which kickstart file is fetched

module Origami
  def set_ks_server(definition_file, server_addr)
    lines = File.new(definition_file, 'r').readlines
    lines.collect do |line|
      if line.include?('boot_cmd_sequence') and line.include?('%%SERVER%%')
        line.gsub('%%SERVER%%',server_addr)
      else
        line
      end
    end
  end
end

if __FILE__==$0
  module Origami
    extend self
  end
  definition_file = File.expand_path('~/Code/otherstuff/ERB/ipreplacement/test_definition.rb')
  server_addr = 'http://192.168.100.225'
  result = Origami.set_ks_server(definition_file, server_addr)
  puts result
end
