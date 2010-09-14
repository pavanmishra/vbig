class ActivityObserver < ActiveRecord::Observer
  observe Event, Organization
  
  def after_create(subject)
    log_activity(subject, :created)
  end
  
  private
  def log_activity(subject, action)
    Activity.log(User.current_user, subject, action) if User.current_user
  end
  
  
end
