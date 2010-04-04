class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.text :description
      t.text :rock_html
      t.text :scissors_html
      t.text :paper_html

      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end
