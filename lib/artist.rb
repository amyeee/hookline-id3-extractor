require 'active_record'

class Artist < ActiveRecord::Base
  has_many :tracks
end
