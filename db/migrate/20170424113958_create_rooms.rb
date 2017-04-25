class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string  :game
      t.string  :game_type
      t.integer :number_of_players
      t.integer :ratings
      t.timestamps
    end
  end
end
