# vim: set tabstop=2 :

class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|

      t.timestamps
      t.belongs_to :from_player, :class_name=> "Player"
      t.belongs_to :to_player, :class_name=> "Player"

    end

  end

  def self.down
    drop_table :invites
  end
end
