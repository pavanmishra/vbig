class ContestSponsor < ActiveRecord::Base
  belongs_to  :contest
  belongs_to  :sponsor
end
