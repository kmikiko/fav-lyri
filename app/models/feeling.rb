class Feeling < ApplicationRecord
  has_many :lyrics_feelings, dependent: :destroy
  has_many :lyrics, through: :lyrics_feelings, source: :lyric
  def self.ransackable_attributes(auth_object = nil)
    %w[sort]
  end

  def self.ransackable_associations(auth_object = nil)
    ["lyrics", "lyrics_feelings"]
  end
end
