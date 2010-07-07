class Invitation < ActiveRecord::Base
  validates_presence_of :by
  validates_presence_of :code
  belongs_to :by, :class_name => 'User', :foreign_key => 'by'
  
  def self.update_invite(code, email)
    invite = self.find_by_code(code)
    invite.by.get_points_for(:invite_accepted)
    invite.update_attribute(:used, true)
  end
  
  def self.random_code
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    random_string  =  (0..30).map{ o[rand(o.length)]  }.join;
    existing_code = self.find_by_code random_string
    # this is recursive call to find a code not used to till now if the duplicate code has been generated
    existing_code ? random_code : random_string
  end
  
end