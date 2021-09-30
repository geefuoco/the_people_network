class RemoveCommentCountFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :comments_count
  end
end
