class Message < ActiveRecord::Base
  belongs_to  :author,        :class_name => 'User'
  has_many    :message_copies
  has_many    :recipients,    :through => :message_copies
  
  before_create :prepare_copies
  attr_accessor  :to # array of people to send to
  attr_accessible :subject, :body, :to
  validates_presence_of :subject 
  
  def prepare_copies
    return if to.blank?
    
    to.each do |recipient|
      recipient = User.find(recipient)
      # strange bug with rails as to not updating the created_at time
      message_copies.build(:recipient_id => recipient.id, :created_at => Time.now)
    end
  end
end
