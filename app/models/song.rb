class Song < ApplicationRecord
  belongs_to :lyric

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[lyric]
  end
end
