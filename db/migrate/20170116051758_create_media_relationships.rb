class CreateMediaRelationships < ActiveRecord::Migration[4.2]
  def change
    create_table :media_relationships do |t|
      t.references :source, polymorphic: true, null: false, index: true
      t.references :destination, polymorphic: true, null: false
      t.integer :role, null: false
    end
  end
end
