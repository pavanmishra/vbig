class CreateContestSponsors < ActiveRecord::Migration
  def self.up
    create_table :contest_sponsors do |t|
      t.integer :contest_id
      t.integer :sponsor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_sponsors
  end
end
