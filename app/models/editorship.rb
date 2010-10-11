class Editorship < ActiveRecord::Base
  belongs_to  :editable, :polymorphic => true
  belongs_to  :editor, :class_name => 'User', :foreign_key => :user_id
end
