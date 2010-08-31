class Badge < ActiveRecord::Base
  has_many :badge_users
  has_many :users, :through => :badge_users
  
  # paperclip image attachment
  has_attached_file :photo, :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  
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
