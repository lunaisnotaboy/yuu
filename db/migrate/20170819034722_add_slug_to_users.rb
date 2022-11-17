class AddSlugToUsers < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'citext'
    add_column :users, :slug, :citext
  end
end
