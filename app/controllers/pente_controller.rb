class PenteController < ApplicationController

  def index
    redirect_to :game_start
  end

  def start
    session[:game] = Pente.new
    redirect_to :board
  end

  def set_stone
    game = Pente.new session[:game].symbolize_keys
    game.set_stone params[:x].to_i, params[:y].to_i unless game.winner
    session[:game] = game
    redirect_to :board
  end

  def board
    @game = Pente.new session[:game].symbolize_keys
  end
end
