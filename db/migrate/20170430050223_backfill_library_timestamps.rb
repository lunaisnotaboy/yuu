require 'update_in_batches'

class BackfillLibraryTimestamps < ActiveRecord::Migration[4.2]
  using UpdateInBatches
  disable_ddl_transaction!

  def change
    LibraryEntry.where('progress > 0').update_in_batches(<<-SQL)
      progressed_at = updated_at,
      finished_at = CASE WHEN status = #{LibraryEntry.statuses[:completed]} THEN updated_at END
    SQL
  end
end
