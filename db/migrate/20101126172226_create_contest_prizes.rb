class CreateContestPrizes < ActiveRecord::Migration
  def self.up
    create_table :contest_prizes do |t|
      t.integer :contest_id
      t.integer :prize_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_prizes
  end
end
