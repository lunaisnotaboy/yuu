class AddIndicesToAllTheThings < ActiveRecord::Migration[4.2]
  def change
    add_index :favorites, %i[user_id item_type]
    add_index :comments, :parent_id
    add_index :comments, :post_id
    add_index :comments, :deleted_at
    add_index :posts, :deleted_at
    add_index :library_entries, %i[user_id media_type]
    add_index :library_entries, :private
    add_index :post_likes, :post_id
    add_index :review_likes, :review_id
    add_index :review_likes, :user_id
    add_index :reviews, :likes_count
  end
end
