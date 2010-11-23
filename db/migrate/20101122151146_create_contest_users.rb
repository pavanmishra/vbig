class CreateContestUsers < ActiveRecord::Migration
  def self.up
    create_table :contest_users do |t|
      t.integer :contest_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_users
  end
end
