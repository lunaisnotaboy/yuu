class AddDefaultsToReactionsCounterCache < ActiveRecord::Migration[4.2]
  def change
    change_column_null :users, :media_reactions_count, false
    change_column_default :users, :media_reactions_count, 0
  end
end
