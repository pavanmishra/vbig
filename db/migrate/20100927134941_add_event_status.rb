class AddEventStatus < ActiveRecord::Migration
  def self.up
    change_table  :events do |t|
      t.column  :status,  :string
    end
  end

  def self.down
    remove_column :events,  :status
  end
end
