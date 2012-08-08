### Input: None
### Copied from Code/tools and modified
###
### (= ~/Code/veewee/os_test/fake_hierarchy/).
### Recursively dig into the directory tree;
### make directories 'typeA' and 'typeB'
### if its name is '32' or '64'.

pwd = Dir.pwd
target_dirs = Dir.glob('**/{typeA,typeB}')
puts 'making .gitignore in leaf directories'
target_dirs.each do |dir|
  Dir.chdir(pwd + '/' + dir)
  if File.exists?('.gitignore')
    #puts "cp #{File.join(pwd,'.gitignore')} #{Dir.pwd}"
    system("cp #{File.join(pwd,'.gitignore')} .")
  end
end
