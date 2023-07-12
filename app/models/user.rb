class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
