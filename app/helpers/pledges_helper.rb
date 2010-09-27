module PledgesHelper
	def format_pledge pledge
	  case pledge.info
    when Pledge::PledgeType[:volunteer_hour][:type]
      "To Volunteer #{pledge.time} hours in the next year (expires)"
    when Pledge::PledgeType[:raise_fund][:type]
      "To raise #{pledge.money} money"
    when Pledge::PledgeType[:recruit_friends][:type]
      "To recruit #{pledge.number} friends"
    when Pledge::PledgeType[:other][:type]            
      pledge.other
	  end
  end
end