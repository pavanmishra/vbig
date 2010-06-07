class Badges::Ambassador < Badge
  
  def self.check_conditions_for(user)
    # check if user is already an ambassador
    user.award(self) if !user.awarded?(self)
  end
  
end