module TournamentsHelper

  def short_tournament_name(name)
    name.match(/SHRS Europe Ev (.+)/)[1]
  end

  def tournament_summary(tournament)
    prize_str = cents_to_money_str(tournament.prize_pool_cents)
    "#{tournament.entrants_count} entries - #{prize_str} prize pool"
  end

  def cents_to_money_str(cents_val)
    number_to_currency(cents_val/100, precision: 0)
  end

end
