class GamesController < ApplicationController

  before_filter :require_authentication

  def play

    @g = Game.find(params[:id])
    @me = Player.find(session[:player_id])
    @pagetitle = "Game #{@g.id}"

    @my_opponent = @g.my_opponent @me

    @my_move = @g.my_move @me

    @opponent_move = @g.my_move @my_opponent

  end

  def move

    if request.post?

      @g = Game.find(params[:game_id])
      @m = @g.my_move(session[:player_id])
      @m.choice = params[:choice]
      @m.save

      flash[:notice] = "Recorded your move (#{@m.choice})."

    end

    redirect_to :action => "play", :id => @g.id

  end

  def open

    # This belongs in SQL.
    @open_games = Game.all.find_all

  end

end
