class AddUserPoints < ActiveRecord::Migration
  def self.up
    change_table  :users do |t|
      t.column  :points,  :integer, :default => 0
    end
  end

  def self.down
  end
end
