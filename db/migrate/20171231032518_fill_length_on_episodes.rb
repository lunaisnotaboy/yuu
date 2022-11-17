class FillLengthOnEpisodes < ActiveRecord::Migration[4.2]
  def change
    Episode.where(length: nil).update_all(<<-SQL.squish)
      length = (SELECT episode_length FROM anime where id = episodes.media_id)
    SQL
  end
end
