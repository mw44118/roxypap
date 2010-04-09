# vim: set tabstop=2 :

class InvitesController < ApplicationController

  def invite

    if request.post?

      Invite.send_invite(session[:player_id], params[:to_player])

      to_player = Player.find(params[:to_player])
      flash[:notice] = "I sent an invite to #{to_player.login}"

      redirect_to :controller => 'players', :action => 'others'

    end

  end

  def received

    @pagetitle = "Invites sent to me"

    @invites_sent_to_me = Invite.all(
      :conditions=>["to_player_id = ?", session[:player_id]])

  end


  def accept

    if request.post?

      me = Player.find(session[:player_id])
      inv = Invite.find(params['invID'])

      g = Game.new.save

      Move.new(:game_id=>g.id, :player_id=>me.id).save
      Move.new(:game_id=>g.id, :player_id=>inv.from_player_id).save

      inv.destroy

      flash[:notice] = "Created game #{g.id}"

      redirect_to :controller => 'games', :action => 'play', :id => g.id

    else

        redirect_to :controller => 'invites', :action => 'received'

    end

  end

end
