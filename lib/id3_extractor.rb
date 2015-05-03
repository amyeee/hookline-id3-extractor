require 'mp3_data'

class Id3Extractor
  def self.extract_mp3_data(mp3_path)
    mp3_data = Mp3Data.new(mp3_path)

    track_attributes = {
      artist:                         mp3_data.artist,
      title:                          mp3_data.title,
      album:                          mp3_data.album,
      year:                           mp3_data.year,
      track_number:                   mp3_data.track_number,
      genre:                          mp3_data.genre,
      composer:                       mp3_data.composer,
      duration_in_seconds:            mp3_data.duration_in_seconds,
      bitrate_in_kilobits_per_second: mp3_data.bitrate_in_kilobits_per_second,
      channels:                       mp3_data.channels,
      sample_rate_in_hertz:           mp3_data.sample_rate_in_hertz
    }

    return track_attributes
  end
end
