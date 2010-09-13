class AddOngoingToEvent < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.column  :ongoing, :boolean
    end
  end

  def self.down
    remove_column :events, :ongoing
  end
end
