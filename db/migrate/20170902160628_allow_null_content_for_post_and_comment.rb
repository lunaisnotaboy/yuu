class AllowNullContentForPostAndComment < ActiveRecord::Migration[4.2]
  def change
    change_column_null :posts, :content, true
    change_column_null :posts, :content_formatted, true
    change_column_null :comments, :content, true
    change_column_null :comments, :content_formatted, true
  end
end
