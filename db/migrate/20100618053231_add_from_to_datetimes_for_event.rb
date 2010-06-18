class AddFromToDatetimesForEvent < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.remove  :datetime
      t.column :from, :datetime
      t.column  :to,  :datetime
    end
  end

  def self.down
    change_table :events do |t|
      t.column  :datetime
      t.remove  :from, :to
    end
  end
end
