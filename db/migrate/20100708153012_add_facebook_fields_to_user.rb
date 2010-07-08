class AddFacebookFieldsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.column  :name         ,:string
      t.column  :sex          ,:string
      t.column  :profile_url  ,:string
      t.column  :pic_square   ,:string
      t.column  :locale       ,:string
      t.column  :middle_name  ,:string
      t.column  :city         ,:string
      t.column  :state        ,:string
      t.column  :country      ,:string
      t.column  :zip          ,:string
    
    end
  end

  def self.down
    change_table :users do |t|
      t.remove  :name, :sex, :profile_url, :pic_square, :locale, :middle_name, :city, :state, :country, :zip
    end
  end
end
