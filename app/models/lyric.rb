class Lyric < ApplicationRecord
  validates :phrase, presence: true, length: { maximum: 20 }
  validates :detail, presence: true
  has_one :artist, dependent: :destroy
  has_one :song, dependent: :destroy
  accepts_nested_attributes_for :artist, allow_destroy: true
  accepts_nested_attributes_for :song, allow_destroy: true
  belongs_to :user
  has_many :lyrics_feelings, dependent: :destroy
  has_many :feelings, through: :lyrics_feelings, source: :feeling

  def self.ransackable_attributes(auth_object = nil)
    %w[phrase]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[artist song feelings]
  end
end
