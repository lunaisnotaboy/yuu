class IndexAozoraIds < ActiveRecord::Migration[4.2]
  disable_ddl_transaction!

  def change
    add_index :users, :ao_id, algorithm: :concurrently, unique: true
    add_index :posts, :ao_id, algorithm: :concurrently, unique: true
    add_index :comments, :ao_id, algorithm: :concurrently, unique: true
  end
end
