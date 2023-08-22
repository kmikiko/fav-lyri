class LyricsFeeling < ApplicationRecord
  belongs_to :lyric
  belongs_to :feeling
  def self.ransackable_attributes(auth_object = nil)
    %w[lyric_id feeling_id]
  end
end
