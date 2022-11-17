class AddSpoilerToReviews < ActiveRecord::Migration[4.2]
  def change
    add_column :reviews, :spoiler, :boolean, default: false, null: false
  end
end
