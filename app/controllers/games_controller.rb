# vim: set tabstop=2 :

class GamesController < ApplicationController

  before_filter :require_authentication

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

      flash[:notice] = "Recorded your move (#{params[:choice]})."

    end

    redirect_to :action => "play", :id => @g.id

  end

  def open

    # This belongs in SQL.
    @open_games = Game.all.find_all

  end

end
