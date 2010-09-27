class CreateUserPledges < ActiveRecord::Migration
  def self.up
    create_table :pledges do |t|
      t.string  :info
      t.float   :time
      t.float   :money
      t.integer :number
      t.string  :other
      t.integer :pledgeable_id
      t.string  :pledgeable_type
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table  :pledges
  end
end
