class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_profile, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :user_profile
  has_many :lyrics
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_lyrics, through: :favorites, source: :lyric
end
