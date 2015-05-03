require 'taglib'

class Id3Data
  attr_reader :artist
  attr_reader :title
  attr_reader :album
  attr_reader :year
  attr_reader :track_nr
  attr_reader :genre

  def initialize(mp3_path)
    TagLib::MPEG::File.open(mp3_path) do |file|
      tag = file.tag
      @title = tag.title
      @artist = tag.artist
      @album = tag.album
      @year = tag.year
      @track_nr = tag.track
      @genre = tag.genre
    end
  end
end
