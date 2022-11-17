class CreateSiteAnnouncements < ActiveRecord::Migration[4.2]
  def change
    create_table :site_announcements do |t|
      t.references :user, foreign_key: true, null: false
      t.text :text, null: true
      t.string :link

      t.timestamps null: false
    end
  end
end
