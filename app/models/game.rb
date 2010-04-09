# vim: set tabstop=2 :

class Game < ActiveRecord::Base

  belongs_to :theme

  belongs_to :inviter, :class_name => "Player"
  belongs_to :invited, :class_name => "Player"

  belongs_to :winner, :class_name => "Player"

  def make_move(myID, move)

    if myID == inviter
      inviter_move = move
    end

    if myID == invited
      invited_move = move
    end

  end


  def game_status()

    if inviter_move and invited_move
      return "finished"
    end

    if inviter_move or invited_move
      return "in progress"
    end

    if accepted
      return "invitation accepted"
    end

    return "invitation sent"

  end


  def winner()

    if inviter_move.nil? or invited_move.nil? or inviter_move == invited_move
      return nil
    end

    if ((inviter_move == 'rock' and invited_move == 'scissors') or (inviter_move == 'scissors' and invited_move == 'paper') or (inviter_move == 'paper' and invited_move == 'rock'))

      return inviter

    else

      return invited

    end

  end


  def self.send_invite(from_player_id, to_player_id)

    g = Game.new(
      :inviter=>from_player_id,
      :invited=>to_player_id)

  end

  def my_opponent(myID)

    if myID == inviter
      return invited
    end

    if myID == invited
      return inviter
    end

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
