class ContestOrganizationUser < ActiveRecord::Base
  belongs_to  :contest
  belongs_to  :organization
  belongs_to  :user
end