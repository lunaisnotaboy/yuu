class BackfillMediaDates < ActiveRecord::Migration[4.2]
  using UpdateInBatches
  disable_ddl_transaction!

  def change
    Anime.where(episode_count: 1)
         .where(start_date: nil)
         .where.not(end_date: nil)
         .update_in_batches('start_date = end_date')

    Anime.where(episode_count: 1)
         .where(end_date: nil)
         .where.not(start_date: nil)
         .update_in_batches('end_date = start_date')

    Manga.where(chapter_count: 1)
         .where(start_date: nil)
         .where.not(end_date: nil)
         .update_in_batches('start_date = end_date')

    Manga.where(chapter_count: 1)
         .where(end_date: nil)
         .where.not(start_date: nil)
         .update_in_batches('end_date = start_date')
  end
end
