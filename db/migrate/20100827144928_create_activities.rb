class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities, :force => true do |t|
      t.references  :user                                           # User who's activity gets recorded.
      t.references  :subject, :polymorphic => true                  # Points to related asset (event, ngo, badge.).
      t.string      :action,  :limit => 32, :default => "created"   # Action taken: created, updated, deleted.
      t.string      :info,    :default => ""                        # Extra information related to the asset and the action.
      t.timestamps
    end

    add_index :activities, :user_id
    add_index :activities, :created_at
  end

  def self.down
    drop_table :activities
  end
end
