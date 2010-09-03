class AddMessagingPreferencesToUser < ActiveRecord::Migration
  def self.up
     change_table :users do |t|
       t.boolean :send_message_notifications
       t.boolean :send_weekly_updates
       t.boolean :send_newsletter
     end
   end

   def self.down
     remove_column :users, :send_message_notifications, :send_weekly_updates, :send_newsletter
   end
end
