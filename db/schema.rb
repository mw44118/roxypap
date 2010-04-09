# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100409193824) do

# Could not dump table "foo" because of following StandardError
#   Unknown type 'bool' for column 'a'

  create_table "games", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "theme_id"
    t.integer  "winner"
    t.integer  "inviter_id"
    t.integer  "invited_id"
    t.text     "inviter_move"
    t.text     "invited_move"
    t.boolean  "accepted",     :default => false
  end

  create_table "invites", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_player_id"
    t.integer  "to_player_id"
  end

  create_table "moves", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "choice"
    t.integer  "game_id"
    t.integer  "player_id"
  end

  create_table "players", :force => true do |t|
    t.text     "login"
    t.text     "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "logged_in"
  end

  create_table "themes", :force => true do |t|
    t.text     "description"
    t.text     "rock_html"
    t.text     "scissors_html"
    t.text     "paper_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
