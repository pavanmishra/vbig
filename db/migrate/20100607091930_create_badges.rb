class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.string :name
      t.string :description
      t.string :type

      t.timestamps
    end
    
    create_table :badge_users do |t|
      t.integer :badge_id
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :badges
  end
end
