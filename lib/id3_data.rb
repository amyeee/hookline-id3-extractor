require 'id3tag'

class Id3Data
  extend Forwardable
  
  def_delegator :@id3_tag, :artist
  def_delegator :@id3_tag, :title
  def_delegator :@id3_tag, :album
  def_delegator :@id3_tag, :track_nr
  def_delegator :@id3_tag, :genre
  
  def initialize(mp3_path)
    mp3_file = File.open(mp3_path, 'rb')
    @id3_tag = ID3Tag.read(mp3_file)
  end
  
  def year
    @id3_tag.year
  rescue ID3Tag::Tag::MultipleFrameError => e
    if e.message =~ /TDRC/
      # If we have duplicate 'year' tags then choose the first
      @id3_tag.get_frames(:TDRC).first.content
    else
      raise e
    end
  end
end
