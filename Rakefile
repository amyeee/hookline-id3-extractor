require File.expand_path('../config/boot.rb', __FILE__)
require 'plist_generator'

desc 'Drop and Recreate production and test database'
task :create_dbs do
  require 'erb'
  require 'yaml'

  config_filename = File.expand_path('../config/config.yml', __FILE__)
  config = YAML.load(File.read(config_filename))

  database_config = config[:database]
  database_config.keys.each do |environment|
    cfg = database_config[environment]
    database = cfg[:database]
    template_filename = File.expand_path('../schema.sql.erb', __FILE__)
    template = File.read(template_filename)
    sql = ERB.new(template).result(binding)
    `mysql -u#{cfg[:username]} -p -h#{cfg[:host]} -e"#{sql}"`
  end
end

desc 'Install launchctl script to start process on boot'
task :install_launchctl_script do
  plist = PlistGenerator.generate
  path  = '~/Library/LaunchAgents/tv.hookline.id3-extractor.plist'
  File.open(File.expand_path(path), 'w') { |f| f.puts(plist) }
  puts "P-list written to #{path}"
end
