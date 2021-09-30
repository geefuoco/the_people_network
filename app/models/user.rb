class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :password, :last_name, presence: true

  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :friends_posts, through: :friends, source: :posts
  has_many :comments
  has_many :likes
end
