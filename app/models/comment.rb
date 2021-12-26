class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, presence: true

  after_create :increment_count
  after_destroy :decrement_count

  private

  def increment_count
    parent = commentable
    while parent.is_a? Comment
      parent = parent.commentable
    end
    parent.increment! :comment_count
  end


  def decrement_count
    parent = commentable
    while parent.is_a? Comment
      parent = parent.commentable
    end
    parent.decrement! :comment_count
  end
end
