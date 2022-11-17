require 'update_in_batches'

class FillNsfwOnLibraryEntries < ActiveRecord::Migration[4.2]
  using UpdateInBatches

  disable_ddl_transaction!

  def up
    LibraryEntry.joins(:anime).merge(Anime.nsfw).update_in_batches(nsfw: true)
    LibraryEntry.joins(:manga).merge(Manga.nsfw).update_in_batches(nsfw: true)
  end

  def down
    LibraryEntry.joins(:anime).merge(Anime.nsfw).update_in_batches(nsfw: false)
    LibraryEntry.joins(:manga).merge(Manga.nsfw).update_in_batches(nsfw: false)
  end
end
