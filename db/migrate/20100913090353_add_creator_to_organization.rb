class AddCreatorToOrganization < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.column  :user_id, :integer
    end
  end

  def self.down
    remove_column :organizations, :user_id
  end
end
