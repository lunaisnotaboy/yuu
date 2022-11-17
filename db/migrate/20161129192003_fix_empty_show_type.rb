class FixEmptyShowType < ActiveRecord::Migration[4.2]
  def change
    say_with_time 'Adding show_type to anime missing it' do
      Anime.where(show_type: nil).update_all(show_type: :TV)
    end
  end
end
