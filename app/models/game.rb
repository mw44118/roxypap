# vim: set tabstop=2 :

class Game < ActiveRecord::Base
  has_many :moves, :class_name => "Move"

  def self.setup_game(player_1_id, player_2_id)

    g = Game.new
    g.save

    m1 = Move.new(:game=>g, :player_id=>player_1_id)

    m2 = Move.new(:game=>g, :player_id=>player_2_id)
    m2.save

    return g

  end

  def my_opponent(me)

    # This could be more efficient if done with SQL
    moves.find_all do |m| m.player != me end [0].player

  end

  def my_move(me)

    Move.first(:conditions=>["game_id = ? and player_id = ?", id, me.id])

  end

  def winner

    m1, m2 = moves

    winning_move = Move.calculate_winning_move(m1, m2)

    if winning_move
      return winning_move.player
    end

  end

end
