class AddAttributesUsedByGeocoder < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.column  :lat, :integer
      t.column  :lng, :integer
    end
  end

  def self.down
    remove_column :organizations, :lat, :lng
  end
end
