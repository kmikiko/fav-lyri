class UserProfile < ApplicationRecord
  belongs_to :user, inverse_of: :user_profile
  mount_uploader :icon, ImageUploader
  validates :name, presence: true
end
