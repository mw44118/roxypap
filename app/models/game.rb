# vim: set tabstop=2 :

class Game < ActiveRecord::Base
  has_many :moves, :class_name => "Move"

  belongs_to :winner, :class_name => "Player"

  def self.setup_game(player_1_id, player_2_id)

    g = Game.new
    g.save

    m1 = Move.new(:game=>g, :player_id=>player_1_id)

    m2 = Move.new(:game=>g, :player_id=>player_2_id)
    m2.save

    return g

  end

  def my_opponent(me)

    moves.find_all do |m| m.player != me end [0].player

  end

  def my_move(myID)
    Move.find_by_game_id_and_player_id id, myID
  end

  def winning_move

    if moves.length != 2
      return nil
    end

    m1, m2 = moves
    Move.calculate_winning_move(m1, m2)

  end

  def winner

    if winning_move
      return winning_move.player
    end

  end

end
