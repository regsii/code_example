class User < ApplicationRecord
  has_many :user_tournaments
  has_many :tournaments, through: :user_tournaments
end
