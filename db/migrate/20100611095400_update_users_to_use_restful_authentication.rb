class UpdateUsersToUseRestfulAuthentication < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.column  :login,                     :string,  :limit => 40
      t.column  :email,                     :string,  :limit => 100
      t.column  :salt,                      :string,  :limit => 40
      t.column  :crypted_password,          :string,  :limit => 40
      t.column  :remember_token,            :string,  :limit => 40
      t.column  :remember_token_expires_at, :datetime
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :login, :email, :salt, :crypted_password, :remember_token, :remember_token_expires_at
      
    end
  end
end
