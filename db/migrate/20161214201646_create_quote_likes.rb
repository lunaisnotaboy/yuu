class CreateQuoteLikes < ActiveRecord::Migration[4.2]
  def change
    create_table :quote_likes do |t|
      t.references :user, index: true, null: false
      t.references :quote, index: true, null: false

      t.timestamps null: false
    end
    # Move existing data
    execute <<-SQL.squish
      INSERT INTO quote_likes (quote_id, user_id, created_at, updated_at)
      SELECT target_id, user_id, created_at, updated_at
      FROM votes
      WHERE target_type = 'Quote'
      AND positive = 't'
    SQL
  end
end
