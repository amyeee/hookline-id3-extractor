require 'id3_extractor'
require 'track'

class TrackCreator
  def self.create_or_update_for(mp3_path)
    mp3_filename = File.basename(mp3_path)
    track_data   = Id3Extractor.extract_id3_data(mp3_path)

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
