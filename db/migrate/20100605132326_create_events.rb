class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :address
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7

      t.timestamps
    end
    add_index :events, [:lat, :lng]
  end

  def self.down
    drop_table :events
    remove_index :events, [:lat, :lng]
  end
end
