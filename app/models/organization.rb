class Organization < ActiveRecord::Base
  acts_as_taggable_on :causes
  has_many  :events
end
