class CreatePointLogs < ActiveRecord::Migration
  def self.up
    create_table :point_logs do |t|
      t.integer :contest_id
      t.integer :user_id
      t.integer :event_id
      t.integer :point

      t.timestamps
    end
  end

  def self.down
    drop_table :point_logs
  end
end
