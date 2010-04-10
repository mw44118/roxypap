require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "Play a game" do

    matt = Player.new(:login=>"matt")
    matt.save

    lindsey = Player.new(:login=>"lindsey")
    lindsey.save

    g = matt.invite(lindsey)
    assert matt.delivered_invites.length == 1, matt.delivered_invites.length
    assert g.game_status == 'invitation sent', g.game_status

    assert lindsey.received_invites.length == 1
    assert matt.delivered_invites.length == 1
    assert lindsey.received_invites[0].id == matt.delivered_invites[0].id

    lindsey.accept_invite(g)
    assert g.game_status == 'invitation accepted', g.game_status

    matt.make_move(g, 'rock')
    assert g.game_status == 'in progress', g.game_status

    lindsey.make_move(g, 'paper')
    assert g.game_status == 'finished', g.game_status

    assert g.winner == lindsey, "winner is #{g.winner.login}."

  end


end
