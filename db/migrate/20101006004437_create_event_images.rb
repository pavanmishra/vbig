class CreateEventImages < ActiveRecord::Migration
  def self.up
    create_table :event_images do |t|
      t.string :caption
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_images
  end
end
