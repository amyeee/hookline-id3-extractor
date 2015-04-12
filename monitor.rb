require File.expand_path('../config/boot.rb', __FILE__)
require 'filewatcher'
require 'track_creator'

puts "Monitoring #{TRACK_DIRECTORY} for new tracks"

FileWatcher.new(File.join(TRACK_DIRECTORY, '**/*.mp3')).watch do |filename|
  mp3_path = File.expand_path(filename)
  next unless File.exists?(mp3_path)

  TrackCreator.create_or_update_for(mp3_path)
end
