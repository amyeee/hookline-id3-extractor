require 'id3tag'

class Id3Extractor
  def self.extract_id3_data(mp3_path)
    mp3_file = File.open(mp3_path, 'rb')
    id3_tag  = ID3Tag.read(mp3_file)

    track_attributes = {
      artist:       id3_tag.artist,
      title:        id3_tag.title,
      album:        id3_tag.album,
      year:         id3_tag.year,
      track_number: id3_tag.track_nr,
      genre:        id3_tag.genre
    }

    return track_attributes
  end
end
