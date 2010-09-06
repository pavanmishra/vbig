class AddCreatorToEvent < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.column :user_id, :integer
    end
  end

  def self.down
    remove_column :events, :user_id
  end
end
