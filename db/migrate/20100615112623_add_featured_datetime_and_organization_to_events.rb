class AddFeaturedDatetimeAndOrganizationToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.column  :organization_id, :integer
      t.column  :featured,  :boolean
      t.column  :datetime,  :datetime
    end
  end

  def self.down
    change_table :events do |t|
      t.remove :organization_id, :featured, :datetime
    end
  end
end
