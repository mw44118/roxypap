# vim: set tabstop=2 :

class GamesController < ApplicationController

  before_filter :require_authentication

  def invite

    if request.post?
      @me = Player.find(session[:player_id])
      @invited = Player.find(params[:to_player])
      @me.invite(@invited)
      flash[:notice] = "Invited #{@invited.login}."
      redirect_to :controller=> :players, :action => :others
    end

  end

  def accept

    if request.post?
      @me = Player.find session[:player_id]
      @g = Game.find params[:game_id]
      @me.accept_invite(@g)

      redirect_to :controller => :games, :action => :play, :id => @g.id
    end

  end

  def play

    @g = Game.find(params[:id])
    @pagetitle = "Game #{@g.id} #{@g.status}"
    @me = Player.find(session[:player_id])
    @my_opponent = @g.my_opponent @me

  end

  def move

    if request.post?

      @g = Game.find(params[:game_id])
      @me = Player.find(session[:player_id])
      @me.make_move(@g, params[:choice])

      flash[:notice] = "Recorded your move."

    end

    redirect_to :action => "play", :id => @g.id

  end

  def my_unfinished_games
    @me = Player.find(session[:player_id])
    @pagetitle = "My unfinished games"

  end

end
