class Feeling < ApplicationRecord
  has_many :lyrics_feelings, dependent: :destroy
  has_many :lyrics, through: :lyrics_feelings, source: :lyric
  validates :sort, presence: true
  def self.ransackable_attributes(auth_object = nil)
    %w[id sort]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[lyrics lyrics_feelings]
  end
end
