class GamesController < ApplicationController

  before_filter :require_authentication

  def play

    logger.debug "params[:id] is #{params[:id]}"

    @g = Game.find(params[:id])
    logger.debug "@g is #{@g}."
    logger.debug "@g.id is #{@g.id}."

    @me = Player.find(session[:player_id])
    @pagetitle = "Game #{@g.id}"

    @my_opponent = @g.my_opponent @me

    @my_move = @g.my_move @me

    @opponent_move = @g.my_move @my_opponent

  end

  def move

    if request.post?

      @g = Game.find(params[:game_id])
      @me = Player.find(session[:player_id])

      @m = Move.first(
        :conditions=>["game_id = ? and player_id = ?", @g.id, @me.id])

      @m.choice = params[:choice]
      @m.save
      flash[:notice] = "Recorded your move (#{@m.choice})."

    end

    redirect_to :action => "play", :id => @g.id

  end

end
