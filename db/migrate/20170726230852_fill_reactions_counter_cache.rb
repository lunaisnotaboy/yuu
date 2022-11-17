require_dependency 'counter_cache_resets'

class FillReactionsCounterCache < ActiveRecord::Migration[4.2]
  disable_ddl_transaction!

  def change
    CounterCacheResets.sql_for(User, :media_reactions, where: 'deleted_at IS NULL').each do |sql|
      execute sql
    end
  end
end
