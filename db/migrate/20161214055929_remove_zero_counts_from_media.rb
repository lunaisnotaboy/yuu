class RemoveZeroCountsFromMedia < ActiveRecord::Migration[4.2]
  def change
    Anime.where(episode_count: 0).update_all(episode_count: nil)
    Manga.where(chapter_count: 0).update_all(chapter_count: nil)
  end
end
