require 'active_record'

class Artist < ActiveRecord::Base
  has_many :tracks
  validates :name, presence: true
end
