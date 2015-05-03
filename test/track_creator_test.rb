require 'bundler/setup'
require 'test-unit'
require 'track_creator'

config_filename = File.expand_path('../../config/config.yml', __FILE__)
config = YAML.load(File.read(config_filename))

connection_settings = config[:database][:test]
ActiveRecord::Base.establish_connection(connection_settings)

class TrackCreatorIntegrationTest < Test::Unit::TestCase
  def setup
    FileUtils.cp original_mp3_path, temporary_mp3_path

    Artist.delete_all
    Track.delete_all
  end

  def teardown
    FileUtils.rm temporary_mp3_path
  end

  def test_should_raise_error_if_the_artist_metadata_is_unavailable
    assert_raise(ActiveRecord::RecordInvalid) do
      TrackCreator.create_or_update_for(temporary_mp3_path)
    end
  end

  def test_should_create_artist_and_track_with_no_metadata
    TagLib::MPEG::File.open(temporary_mp3_path) do |file|
      tag = file.tag
      tag.artist = 'artist-string'
      file.save
    end

    TrackCreator.create_or_update_for(temporary_mp3_path)

    assert_equal 1, Artist.count
    assert_equal 1, Artist.first.tracks.length
    assert_equal 'artist-string', Artist.first.name

    assert_equal 1, Track.count
    assert_equal 'empty-id3-tags.temporary.mp3', Track.first.filename
    assert_nil Track.first.album
    assert_nil Track.first.title
    assert_equal 0, Track.first.year
    assert_equal 0, Track.first.track_number
    assert_nil Track.first.genre
  end

  def test_should_create_new_artist_and_track
    TagLib::MPEG::File.open(temporary_mp3_path) do |file|
      tag = file.tag
      tag.artist = 'artist-string'
      tag.album = 'album-string'
      tag.title = 'song-name-string'
      tag.year = 2015
      tag.track = 3
      tag.genre = 'Blues'

      tag = file.id3v2_tag
      tcom = TagLib::ID3v2::TextIdentificationFrame.new('TCOM', TagLib::String::UTF8)
      tcom.text = 'composer-string'
      tag.add_frame(tcom)

      file.save
    end

    TrackCreator.create_or_update_for(temporary_mp3_path)

    assert_equal 1, Artist.count
    assert_equal 1, Artist.first.tracks.length
    assert_equal 'artist-string', Artist.first.name

    assert_equal 1, Track.count
    assert_equal 'empty-id3-tags.temporary.mp3', Track.first.filename
    assert_equal 'album-string', Track.first.album
    assert_equal 'song-name-string', Track.first.title
    assert_equal 2015, Track.first.year
    assert_equal 3, Track.first.track_number
    assert_equal 'Blues', Track.first.genre
    assert_equal 'composer-string', Track.first.composer
  end

  private

  def temporary_mp3_path
    File.expand_path('../fixtures/empty-id3-tags.temporary.mp3', __FILE__)
  end

  def original_mp3_path
    # The empty-id3-tags.mp3 was downloaded from http://www.xamuel.com/blank-mp3s/
    File.expand_path('../fixtures/empty-id3-tags.mp3', __FILE__)
  end
end
