class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.includes(:users).find(params[:event_id])
    @leaders = @tournament.user_tournaments.sort_by(&:place)[0..8]
  end

end
