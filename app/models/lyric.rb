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
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[id phrase]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[artist song feelings lyrics_feelings]
  end

  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and lyric_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        lyric_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(lyric_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      lyric_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
