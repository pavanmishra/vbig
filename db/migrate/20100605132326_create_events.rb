class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :address
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
    add_index :events, [:lat, :lng]
  end

  def self.down
    drop_table :events
    remove_index :events, [:lat, :lng]
  end
end
