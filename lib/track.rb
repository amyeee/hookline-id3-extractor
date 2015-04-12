require 'active_record'

class Track < ActiveRecord::Base
  validates :filename, uniqueness: true
end
