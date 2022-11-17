class AddReleaseScheduleToMedia < ActiveRecord::Migration[4.2]
  def change
    add_column :anime, :release_schedule, :text
    add_column :manga, :release_schedule, :text
    add_column :dramas, :release_schedule, :text
  end
end
