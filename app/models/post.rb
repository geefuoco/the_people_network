class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :likes
  has_one_attached :image
end
