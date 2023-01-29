class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.decimal :points_qual, precision: 6, scale: 5
      t.integer :prize_pool_cents
      t.integer :buy_in_cents
      t.integer :entrants_count
      t.date :date

      t.timestamps
    end
  end
end
