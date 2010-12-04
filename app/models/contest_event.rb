class ContestEvent < ActiveRecord::Base
  belongs_to  :contest
  belongs_to  :event
end
