class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, presence: true
end
