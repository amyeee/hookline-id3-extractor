require File.expand_path('../config/boot.rb', __FILE__)
require 'plist_generator'

desc 'Install launchctl script to start process on boot'
task :install_launchctl_script do
  plist = PlistGenerator.generate
  path  = '~/Library/LaunchAgents/tv.hookline.id3-extractor.plist'
  File.open(File.expand_path(path), 'w') { |f| f.puts(plist) }
  puts "P-list written to #{path}"
end
