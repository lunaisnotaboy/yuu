require 'update_in_batches'

class FillMediaAssociationsOnLibraryEntry < ActiveRecord::Migration[4.2]
  using UpdateInBatches

  disable_ddl_transaction!

  def up
    say_with_time 'Filling anime_id column' do
      LibraryEntry.where(media_type: 'Anime')
                  .update_in_batches('anime_id = media_id')
    end
    say_with_time 'Filling manga_id column' do
      LibraryEntry.where(media_type: 'Manga')
                  .update_in_batches('manga_id = media_id')
    end
  end

  def down
    LibraryEntry.all.update_in_batches(manga_id: nil, anime_id: nil)
  end
end
