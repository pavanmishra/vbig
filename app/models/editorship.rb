class Editorship < ActiveRecord::Base
  belongs_to  :editable, :polymorphic => true
  belongs_to  :editor, :class_name => 'User', :foreign_key => :user_id
  belongs_to  :event, :class_name => 'Event', :foreign_key => :editable_id
  belongs_to  :organization, :class_name => 'Organization', :foreign_key => :editable_id  
  # its complicated for now and needs review for better way to implement it
  # till then the method suggested by Josh Susser is used http://blog.hasmanythrough.com/2006/4/3/polymorphic-through
end
