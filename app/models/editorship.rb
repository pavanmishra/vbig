class Editorship < ActiveRecord::Base
  belongs_to  :editable, :polymorphic => true
end
