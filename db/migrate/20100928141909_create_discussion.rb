class CreateDiscussion < ActiveRecord::Migration
  def self.up
    create_table  :discussions  do |t|
      t.column  :title,           :string
      t.column  :description,     :string
      t.column  :address,         :string
      t.column  :user_id,         :integer
      t.column  :organization_id, :integer
      t.column  :featured,        :boolean
      t.decimal  :lat,                :precision => 10, :scale => 7
      t.decimal  :lng,                :precision => 10, :scale => 7

      
      t.timestamps
    end
  end

  def self.down
    drop_table  :discussions
  end
end
