require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "Play a bunch of games" do

    matt = Player.new(:login=>"matt", :password=>"1234")
    matt.save

    assert matt == Player.authenticate(matt.login, matt.password)

    lindsey = Player.new:login=>"lindsey", :password=>"5678"
    lindsey.save

    charlie = Player.new :login => "charlie", :password => "9012"
    charlie.save

    oliver = Player.new :login => "oliver", :password => "9012"
    oliver.save

    assert Player.count == 4, "There are #{Player.count} players!"

    g = matt.invite(lindsey)

    assert matt.delivered_invites.length == 1,
    matt.delivered_invites.length

    assert g.status == 'invitation sent', g.status
    assert g.inviter == matt

    assert lindsey.games_finished.length == 0
    assert matt.games_finished.length == 0
    assert charlie.games_finished.length == 0
    assert oliver.games_finished.length == 0

    assert lindsey.received_invites.length == 1
    assert matt.delivered_invites.length == 1
    assert lindsey.received_invites[0].id == matt.delivered_invites[0].id

    assert charlie.received_invites.length == 0
    assert charlie.delivered_invites.length == 0

    assert oliver.received_invites.length == 0
    assert oliver.delivered_invites.length == 0

    lindsey.accept_invite(g)
    assert g.status == 'invitation accepted', g.status
    assert g.invited == lindsey

    assert lindsey.received_invites.length == 0
    assert matt.delivered_invites.length == 0

    matt.make_move(g, 'rock')

    assert g.inviter_move == 'rock',
    "inviter_move (matt's move) is #{g.inviter_move}."

    assert g.status == 'in progress', g.status

    lindsey.make_move(g, 'paper')
    assert g.status == 'finished', g.status

    assert g.figure_out_winner == lindsey,
    "figure_out_winner returned #{g.figure_out_winner.login}."

    assert g.winner == lindsey, "g.winner is #{g.winner}."

    assert lindsey.games_finished.length == 1
    assert matt.games_finished.length == 1
    assert charlie.games_finished.length == 0
    assert oliver.games_finished.length == 0

    assert lindsey.games_won.length == 1,
    "lindsey won #{lindsey.games_won.length} games."

    assert lindsey.games_won.length == lindsey.number_of_wins

    assert matt.games_won.length == 0,
    "matt won #{matt.games_won.length} games."

    assert matt.games_won.length == matt.number_of_wins

    lb = Player.leaderboard
    assert lb.length == Player.count, "lb is #{lb}."

    assert lb[0] == lindsey, "lb[0].login is #{lb[0].login}."

    charlie.invite(lindsey)

    assert lindsey.received_invites.length == 1
    assert matt.delivered_invites.length == 0
    assert charlie.delivered_invites.length == 1

    # Now play a tie game
    g = matt.invite(lindsey)

    lindsey.accept_invite(g)

    matt.make_move(g, 'scissors')
    lindsey.make_move(g, 'scissors')

    assert g.status == 'tied', g.status
    assert g.winner == nil

    assert lindsey.number_of_wins == 1
    assert matt.number_of_wins == 0

    g = charlie.invite(matt)
    matt.accept_invite(g)
    matt.make_move(g, 'scissors')
    charlie.make_move(g, 'paper')

    assert matt.my_record == '1-1-1', matt.my_record

    assert Player.leaderboard == [matt, lindsey, charlie, oliver]

  end

end
