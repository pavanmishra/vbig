class CreateContestOrganizations < ActiveRecord::Migration
  def self.up
    create_table :contest_organizations do |t|
      t.integer :contest_id
      t.integer :organization_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_organizations
  end
end
