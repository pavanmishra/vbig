class AddContestPointToActivity < ActiveRecord::Migration
  def self.up
    change_table  :activities  do |t|
      t.integer :parent_id
      t.integer :contest_id
      t.integer :points
    end
  end

  def self.down
    remove_columns :activities, :parent_id, :contest_id, :points
  end
end
