class Comment < ApplicationRecord
  belongs_to :lyric
  validates :content, presence: true
end
