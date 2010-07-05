class Invitation < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.column  :code,  :string, :length => 30
      t.column  :by,    :integer
      t.column  :email, :string
      t.column  :used,  :boolean, :default => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
