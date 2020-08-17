class CreateSpotifyCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :spotify_credentials, id: false do |t|
      t.integer :user_id
      t.string :token
      t.string :refresh_token
      t.integer :expires_at
      t.boolean :expires

      t.timestamps
    end
  end
end
