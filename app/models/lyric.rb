class Lyric < ApplicationRecord
  validates :phrase, presence: true, length: { maximum: 20 }
  validates :detail, presence: true
  has_one :artist
  has_one :song
  accepts_nested_attributes_for :artist, allow_destroy: true
  accepts_nested_attributes_for :song, allow_destroy: true
end
