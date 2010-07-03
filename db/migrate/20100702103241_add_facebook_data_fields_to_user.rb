class AddFacebookDataFieldsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.column  :facebook_user_id,       :integer
      t.column  :facebook_access_token, :integer
    end
  end

  def self.down
    change_table  :users do |t|
      t.remove  :facebook_user_id, :facebook_access_token
    end
  end
end
