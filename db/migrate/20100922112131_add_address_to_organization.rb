class AddAddressToOrganization < ActiveRecord::Migration
  def self.up
    change_table  :organizations  do |t|
      t.column  :address, :string
    end
  end

  def self.down
    remove_column :organizations, :address
  end
end
