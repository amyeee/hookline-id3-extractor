require 'taglib'

class Id3Data
  attr_reader :artist
  attr_reader :title
  attr_reader :album
  attr_reader :year
  attr_reader :track_nr
  attr_reader :genre
  attr_reader :composer
  attr_reader :duration_in_seconds

  def initialize(mp3_path)
    TagLib::MPEG::File.open(mp3_path) do |file|
      tag = file.tag
      @title = tag.title
      @artist = tag.artist
      @album = tag.album
      @year = tag.year
      @track_nr = tag.track
      @genre = tag.genre

      tag = file.id3v2_tag
      composer_frame = tag.frame_list('TCOM')
      unless composer_frame.empty?
        @composer = composer_frame.first.field_list.first
      end

      properties = file.audio_properties
      @duration_in_seconds = properties.length
    end
  end
end
