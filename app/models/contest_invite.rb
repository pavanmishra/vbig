class ContestInvite < ActiveRecord::Base
  belongs_to  :invitable, :polymorphic => true
  belongs_to  :contest
  belongs_to  :inviter, :class_name => 'User'
  belongs_to  :invitee, :class_name => 'User'
  
  validates_presence_of :code
  
  def self.create_for_invitable params, inviter
     invite_params = {:contest_id => params[:id], :invitable_id => params[:for_id], :invitable_type => params[:for].capitalize, :inviter_id => inviter.id}
     self.first(:conditions => invite_params) or self.create(invite_params.merge(:code => self.random_code))
  end
  
  def self.random_code
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    random_string  =  (0..30).map{ o[rand(o.length)]  }.join;
    existing_code = self.find_by_code random_string
    # this is recursive call to find a code not used to till now if the duplicate code has been generated
    existing_code ? random_code : random_string
  end
  
end
