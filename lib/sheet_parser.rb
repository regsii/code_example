require 'logger'

module DataProcessor

  class UnexpectedSheetStructureError < StandardError
    def initialize(msg='non-empty row is found before any "header" row (parser expects 1st non-empty row to start with "SHRS")')
      super
    end
  end

  class SheetDataParser
    LBL_POINTS_QUAL = "Points Qual."
    LBL_PRIZE_POOL = "Prize Pool"
    LBL_BUY_IN = "Buy-In"
    LBL_ENTRANTS = "Entrants"
    LBL_DATE = "Date"

    LBL_PLAYER_PLACE = "Place"
    LBL_PLAYER_NAME = "Player name"

    attr_reader :tournaments_models

    def initialize(sheet_data)
      @sheet_data = sheet_data
    end

    def run
      @tournaments_models ||= process_and_save_tournaments_data
    end

    # === === === === === PRIVATE === === === === ===

    private

      def process_and_save_tournaments_data
        tournaments_data.map { |o| process_and_save_tournament_obj(o) }
      end

      def tournaments_data
        @sheet_data.values.inject([]) do |tournaments, row|
          case row[0]
          when /^\d+$/ # digits only
            raise UnexpectedSheetStructureError unless tournaments.last
            tournaments.last[:prize_winners].push(row)
          when /^Place$/ # Place
            raise UnexpectedSheetStructureError unless tournaments.last
            tournaments.last.merge!(cfg: row)
          when /^SHRS.+/ # starts with SHRS
            tournaments.push(head: row, prize_winners: [])
          when /.+/ # other non-empty
            logger.warn 'parser could not understand this line: ' + row.to_s
          end
          tournaments
        end
      end

      def process_and_save_tournament_obj(trn)
        head = trn[:head]
        cfg = trn[:cfg]
  
        col_idx_points_qual = head.index(LBL_POINTS_QUAL)
        col_idx_prize_pool = head.index(LBL_PRIZE_POOL)
        col_idx_buy_in = head.index(LBL_BUY_IN)
        col_idx_entrants = head.index(LBL_ENTRANTS)
        col_idx_date = head.index(LBL_DATE)
        player_col_idx_place = cfg.index(LBL_PLAYER_PLACE)
        player_col_idx_name = cfg.index(LBL_PLAYER_NAME)
  
        tournament_model = Tournament.create!(
          name: head[0],
          points_qual: cfg[col_idx_points_qual],
          prize_pool_cents: money_str_to_cents_int(cfg[col_idx_prize_pool]),
          buy_in_cents: money_str_to_cents_int(cfg[col_idx_buy_in]),
          entrants_count: cfg[col_idx_entrants],
          date: Date::strptime(cfg[col_idx_date], '%m/%d/%y')
        )
  
        trn[:prize_winners].each do |wnr|
          user_model = User.find_or_create_by!(name: wnr[player_col_idx_name])
          UserTournament.create!(
            user: user_model,
            tournament: tournament_model,
            place: wnr[player_col_idx_place],
            points: wnr[col_idx_points_qual],
            prize_cents: money_str_to_cents_int(wnr[col_idx_prize_pool])
          )
        end
  
        tournament_model.reload
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def money_str_to_cents_int(dollar_str)
        dollar_str.gsub(/\D/, '').to_i * 100
      end

  end

end
