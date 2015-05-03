require 'id3_data'

class Id3Extractor
  def self.extract_id3_data(mp3_path)
    id3_data = Id3Data.new(mp3_path)

    track_attributes = {
      artist:                         id3_data.artist,
      title:                          id3_data.title,
      album:                          id3_data.album,
      year:                           id3_data.year,
      track_number:                   id3_data.track_nr,
      genre:                          id3_data.genre,
      composer:                       id3_data.composer,
      duration_in_seconds:            id3_data.duration_in_seconds,
      bitrate_in_kilobits_per_second: id3_data.bitrate_in_kilobits_per_second,
      channels:                       id3_data.channels,
      sample_rate_in_hertz:           id3_data.sample_rate_in_hertz
    }

    return track_attributes
  end
end
