class AddWinnerToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :winner, :integer
  end

  def self.down
    remove_column :games, :winner
  end
end
