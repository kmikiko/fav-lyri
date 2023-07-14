class Feeling < ApplicationRecord
  has_many :lyrics_feelings, dependent: :destroy
  has_many :lyrics, through: :lyrics_feelings, source: :lyric
end
