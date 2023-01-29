class CreateUserTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tournaments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.integer :place
      t.integer :points
      t.integer :prize_cents

      t.timestamps

      t.index [:user_id, :tournament_id]
      t.index [:tournament_id, :user_id]
    end
  end
end
