class MessageCopy < ActiveRecord::Base
  belongs_to  :message
  belongs_to  :recipients,  :class_name => 'User'
  delegate    :author, :created_at, :subject, :body, :recipients, :to => :message
end
