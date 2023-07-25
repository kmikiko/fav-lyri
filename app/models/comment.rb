class Comment < ApplicationRecord
  belongs_to :lyric
  belongs_to :user
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
end
