class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  validates :name, :email, :password, presence: true

  has_many :posts
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :friends_posts, through: :friends, source: :posts
  has_many :comments
  has_many :likes
  has_many :outgoing_friend_requests, foreign_key: "requestor_id", class_name: :FriendRequest
  has_many :notifications, foreign_key: :recipient_id
  has_one_attached :avatar

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.name = auth.info.name
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
