class CreateEditorships < ActiveRecord::Migration
  def self.up
    create_table :editorships do |t|
      t.integer :editable_id
      t.string :editable_type
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :editorships
  end
end
