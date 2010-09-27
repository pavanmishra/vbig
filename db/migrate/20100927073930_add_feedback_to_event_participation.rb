class AddFeedbackToEventParticipation < ActiveRecord::Migration
  def self.up
    change_table  :event_users do |t|
      t.column  :hours,     :float
      t.column  :attended,  :boolean
      t.column  :comment,   :text
    end
  end

  def self.down
    remove_column :event_users, :hours, :attended,  :comment
  end
end
