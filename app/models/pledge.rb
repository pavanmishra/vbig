class Pledge  < ActiveRecord::Base
  
  belongs_to :user 
=begin
  # will need a better validation code.
  [:time, :money, :number].each do |numerical_attribute|
    validates_numericality_of numerical_attribute, :if => Proc.new{|pledge| PledgeType[pledge.info.to_sym][:should_be_number] and PledgeType[pledge.info.to_sym]}
  end
=end
  
  PledgeType = {
    :volunteer_hour => {:type => 'volunteer_hour', :requires => 'time', :err_msg => 'Invalid amount for time.', :should_be_number => true},
    :raise_fund => {:type => 'raise_fund', :requires => 'money', :err_msg => 'Invalid amount of money', :should_be_number => true},
    :recruit_friends => {:type => 'recruit_friends', :requires => 'number', :err_msg => 'Not a number', :should_be_number => true},
    :other => {:type => 'other', :requires => 'other', :err_msg => 'Come on you can pledge anything'}  }
    
  protected
  
  def validate
    errors.add(PledgeType[self.info.to_sym][:requires], PledgeType[self.info.to_sym][:err_msg]) unless PledgeType[self.info.to_sym] and !self.send(PledgeType[self.info.to_sym][:requires]).blank?
#    errors.add(PledgeType[self.info.to_sym][:requires], PledgeType[self.info.to_sym][:err_msg]) if PledgeType[self.info.to_sym][:should_be_number] and (self.send(PledgeType[self.info.to_sym][:requires]) !~ /\d+/)
  end
end