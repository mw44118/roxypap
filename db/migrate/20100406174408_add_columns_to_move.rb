class AddColumnsToMove < ActiveRecord::Migration

  def self.up

    add_column :moves, :game_id, :integer
    add_column :moves, :player_id, :integer

  end

  def self.down

    remove_column :moves, :game_id
    remove_column :moves, :player_id

  end

end
