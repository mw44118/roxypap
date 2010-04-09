require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end


  test "Game Invite" do

    matt = Player.new(:login=>"matt")
    lindsey = Player.new(:login=>"lindsey")

    g = matt.invite(lindsey)
    puts "g is #{g}."
    puts "g.inviter.login is #{g.inviter.login}."
    puts "g.invited.login is #{g.invited.login}."
    puts "g.accepted is #{g.accepted}."


    puts "lindsey received invites length: #{lindsey.received_invites.length}"
    assert lindsey.received_invites.length == 1
    assert matt.delivered_invites.length == 1
    assert lindsey.received_invites[0].id == matt.delivered_invites[0].id

  end


end
