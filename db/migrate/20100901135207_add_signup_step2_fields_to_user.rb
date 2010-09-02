class AddSignupStep2FieldsToUser < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.column  :about_me,      :text
      t.column  :fighting_for,  :text
    end
  end

  def self.down
    remove_column :about_me, :fighting_for
  end
end
