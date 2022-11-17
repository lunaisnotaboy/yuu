class CreateGroupCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :group_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.timestamps null: false
    end
  end
end
