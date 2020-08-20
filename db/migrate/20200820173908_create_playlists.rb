class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.text :description
      t.string :spotify_id
      t.references :group

      t.timestamps
    end
  end
end
