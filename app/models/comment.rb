class Comment < ApplicationRecord
  belongs_to :lyric
  belongs_to :user
  validates :content, presence: true
end
