class Badge < ActiveRecord::Base
  has_many :badge_users
  has_many :users, :through => :badge_users
  
  def self.check_conditions_for(user)
    if ! user.awarded?(self)
      user.award(self) 
    end
  end
  
  # this method fixes a problem introduced by STI
  # for further reference refer here http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html
  def self.model_name
    name = 'badge'
    name.instance_eval do
      def plural; pluralize end
      def singular; singularize end
      def human;  singularize end
    end
    return name
  end
end
