class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  validates :name, :email, :password, presence: true

  has_many :posts, dependent: :delete_all
  has_many :friendships, dependent: :delete_all
  has_many :friends, through: :friendships, dependent: :delete_all
  has_many :friends_posts, through: :friends, source: :posts
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  #perhaps put these together and create selectors in the controller like with friendships
  has_many :outgoing_friend_requests, foreign_key: "requestor_id", class_name: :FriendRequest, dependent: :delete_all
  has_many :incoming_friend_requests, foreign_key: "recipient_id", class_name: :FriendRequest, dependent: :delete_all


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
