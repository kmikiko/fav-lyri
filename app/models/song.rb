class Song < ApplicationRecord
  belongs_to :lyric
  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end
end
