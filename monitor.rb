require File.expand_path('../config/boot.rb', __FILE__)
require 'digest'
require 'fileutils'
require 'track_creator'

DIGEST_DIRECTORY = File.expand_path('../tmp/digests', __FILE__)
FileUtils.mkdir_p(DIGEST_DIRECTORY)

LOGGER.info "Monitoring #{TRACK_DIRECTORY} for new tracks"

while true
  LOGGER.info 'Checking for new/changed files'

  Dir[File.join(TRACK_DIRECTORY, '**/*.mp3')].each do |filename|
    mp3_path = File.expand_path(filename)

    digest = Digest::MD5.file(mp3_path).hexdigest
    digest_path = File.join(DIGEST_DIRECTORY, digest)

    unless File.exists?(digest_path)
      LOGGER.info "New or changed file: #{File.basename(mp3_path)}"
      FileUtils.touch(digest_path)

      begin
        TrackCreator.create_or_update_for(mp3_path)
      rescue ActiveRecord::RecordInvalid
        LOGGER.info "Artist not found in #{mp3_path}"
        LOGGER.info "Skipping in the hope that it's caused by reading a partially copied file"
      end
    end
  end

  LOGGER.info 'Finished checking'

  sleep 30
end
