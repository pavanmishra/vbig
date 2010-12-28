class ChangingTypeOfFacebookAccesCodeInUser < ActiveRecord::Migration
  def self.up
    change_column :users, :facebook_access_token, :string
  end

  def self.down
    change_column :users, :facebook_access_token, :integer
  end
end
