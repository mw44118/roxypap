class DoEverythingInOneTable < ActiveRecord::Migration
  def self.up

    add_column :games, :inviter, :integer
    add_column :games, :invited, :integer
    add_column :games, :inviter_move, :text
    add_column :games, :invited_move, :text

  end

  def self.down
    remove_column :games, :inviter
    remove_column :games, :invited
    remove_column :games, :inviter_move
    remove_column :games, :invited_move
    remove_column :games, :winner
  end

end
