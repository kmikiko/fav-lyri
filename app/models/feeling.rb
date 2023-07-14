class Feeling < ApplicationRecord
  has_many :lyrics_feelings, dependent: :destroy
  has_many :lyrics, through: :lyrics_feelings, source: :lyric
  self.inheritance_column = :_type_disabled
end
