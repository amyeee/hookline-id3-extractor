require 'bundler/setup'
require 'test-unit'
require 'track_creator'

config_filename = File.expand_path('../../config/config.yml', __FILE__)
config = YAML.load(File.read(config_filename))

connection_settings = config[:database][:test]
ActiveRecord::Base.establish_connection(connection_settings)

<<-EndReadme
The test.mp3 was downloaded from http://www.xamuel.com/blank-mp3s/
and edited using id3tag from id3lib

id3tag test/fixtures/test.mp3 \
 --artist="artist-string" \
 --album="album-string" \
 --song="song-name-string" \
 --year="2015" \
 --track="03"

 NOTE. I tried to set the genre but whatever I try it comes out as Blues so that's what I'm testing below.
EndReadme

class TrackCreatorIntegrationTest < Test::Unit::TestCase
  def test_should_create_new_artist_and_track
    Artist.delete_all
    Track.delete_all

    mp3_path = File.expand_path('../fixtures/test.mp3', __FILE__)
    TrackCreator.create_or_update_for(mp3_path)

    assert_equal 1, Artist.count
    assert_equal 1, Artist.first.tracks.length
    assert_equal 'artist-string', Artist.first.name

    assert_equal 1, Track.count
    assert_equal 'test.mp3', Track.first.filename
    assert_equal 'album-string', Track.first.album
    assert_equal 'song-name-string', Track.first.title
    assert_equal 2015, Track.first.year
    assert_equal 3, Track.first.track_number
    assert_equal 'Blues', Track.first.genre
  end
end
