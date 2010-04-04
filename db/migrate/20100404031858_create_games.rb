class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|

      t.timestamps

      t.belongs_to :theme



    end
  end

  def self.down
    drop_table :games
  end
end
