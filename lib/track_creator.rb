require 'mp3_data_extractor'
require 'artist'
require 'track'

class TrackCreator
  def self.create_or_update_for(mp3_path)
    mp3_filename = File.basename(mp3_path)
    track_data   = Mp3DataExtractor.extract_mp3_data(mp3_path)
    artist_name  = track_data.delete(:artist)
    artist       = Artist.find_or_create_by!(name: artist_name)
    track_data.merge!(artist: artist)

    if track = Track.find_by_filename(mp3_filename)
      track.update_attributes!(track_data)
      puts "Existing track updated: #{mp3_filename}"
    else
      track_data.merge!(
        filename: mp3_filename
      )
      Track.create!(track_data)
      puts "New track created: #{mp3_filename}"
    end
  end
end
