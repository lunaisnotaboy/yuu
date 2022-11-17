class ExpandSiteAnnouncements < ActiveRecord::Migration[4.2]
  def change
    add_column :site_announcements, :title, :string, null: false
    add_column :site_announcements, :image_url, :string
    rename_column :site_announcements, :text, :description
  end
end
