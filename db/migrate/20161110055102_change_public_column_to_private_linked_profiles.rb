class ChangePublicColumnToPrivateLinkedProfiles < ActiveRecord::Migration[4.2]
  def change
    rename_column :linked_profiles, :public, :private
    change_column_default :linked_profiles, :private, true
  end
end
