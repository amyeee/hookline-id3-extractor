require 'active_record'

class Track < ActiveRecord::Base
  belongs_to :artist
  validates :filename, uniqueness: true
end
