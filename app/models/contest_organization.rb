class ContestOrganization < ActiveRecord::Base
  belongs_to  :contest
  belongs_to  :organization
end
