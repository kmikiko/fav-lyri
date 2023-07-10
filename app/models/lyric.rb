class Lyric < ApplicationRecord
  validates :phrase, presence: true, length: { maximum: 20 }
  validates :detail, presence: true
end
