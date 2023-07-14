class Artist < ApplicationRecord
  belongs_to :lyric

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
