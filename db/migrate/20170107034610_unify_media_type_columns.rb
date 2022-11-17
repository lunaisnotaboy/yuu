class UnifyMediaTypeColumns < ActiveRecord::Migration[4.2]
  def change
    rename_column :manga, :manga_type, :subtype
    rename_column :anime, :show_type, :subtype
    rename_column :dramas, :show_type, :subtype
  end
end
