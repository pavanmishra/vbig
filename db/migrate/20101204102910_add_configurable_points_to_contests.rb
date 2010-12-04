class AddConfigurablePointsToContests < ActiveRecord::Migration
  def self.up
    change_table :contests do |t|
      t.integer :pledge_points, :default => 0
      t.integer :invite_points, :default => 0
    end
  end

  def self.down
    remove_column :contests, :pledge_points, :invite_points
  end
end
