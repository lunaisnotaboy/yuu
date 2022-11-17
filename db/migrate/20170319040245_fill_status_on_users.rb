require 'update_in_batches'

class FillStatusOnUsers < ActiveRecord::Migration[4.2]
  using UpdateInBatches

  disable_ddl_transaction!

  def change
    say_with_time 'Filling status column' do
      User.all.update_in_batches(status: 1)
    end
    change_column_null :users, :status, false, 1
    change_column_default :users, :status, 1
  end
end
