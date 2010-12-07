class AddFacebookMessageToContest < ActiveRecord::Migration
  def self.up
    change_table  :contests do |t|
      t.string  :facebook_message, :default => ''
    end
  end

  def self.down
    remove_column :contests, :facebook_message
  end
end
