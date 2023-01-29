class Tournament < ApplicationRecord
  has_many :user_tournaments
  has_many :users, through: :user_tournaments
end
