class AddMessageReaded < ActiveRecord::Migration
  def self.up
    change_table  :message_copies do |t|
      t.boolean :read
    end
  end

  def self.down
    remove_column :message_copies, :read
  end
end
