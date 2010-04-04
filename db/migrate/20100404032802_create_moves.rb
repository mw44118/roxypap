class CreateMoves < ActiveRecord::Migration
  def self.up
    create_table :moves do |t|

      t.timestamps
      t.text :choice
    end
  end

  def self.down
    drop_table :moves
  end
end
