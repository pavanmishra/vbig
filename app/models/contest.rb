class Contest < ActiveRecord::Base
  has_many :contest_users
  has_many  :users, :through => :contest_users, :uniq => true
  has_many  :contest_organizations
  has_many  :organizations, :through => :contest_organizations, :uniq => true
  has_many  :contest_sponsors
  has_many  :sponsors, :through => :contest_sponsors, :uniq => true
  has_many  :contest_prizes
  has_many  :prizes, :through => :contest_prizes, :uniq => true
  has_many  :contest_events
  has_many  :events, :through => :contest_events, :uniq => true
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  has_attached_file :image, :path => ':rails_root/public/system/images/contests/:attachment/:id/:style/:filename', 
        :url => '/system/images/contests/:attachment/:id/:style/:filename',
        :styles => {
          :small_thumbnail => "75x79#",
          :smaller_thumbnail => "60x60#",
          :thumb=> "100x100>",
          :small  => "150x150>",
          :medium => "200x200>",
          :large =>   "400x400>"
        }
  # used by will_paginate
  cattr_reader :per_page
  @@per_page = 10
  
  def user_score_list(page_no, count)
    activities = Activity.find_by_sql("select sum(points) as total_points, user_id from activities where contest_id=#{self.id} group by user_id order by sum(points) desc limit #{page_no}, #{count}")
    score_list = activities.collect{|act| [act.user_id, act.total_points] }
    if score_list.length < count 
      existing_ids = score_list.length.eql?(0) ? [0] : score_list.collect{|score| score.first}
      users_no_point = users.all(:conditions => "users.id not in (#{existing_ids})", :limit => (count - score_list.length))
      users_no_point.each{|user| score_list << [user.id, 0]}
    end
    return score_list
  end
  
  def has_voted?(user, organization)
    ContestOrganizationUser.find(:first, :conditions => {:contest_id => self, :user_id => user, :organization_id => organization})
  end
  
  def organization_score_list(page_no, count)
    activities = Activity.find_by_sql("select sum(points) as total_points, subject_id from activities where contest_id=#{self.id} and subject_type='Organization' group by subject_id order by sum(points) desc limit 5")
    score_list = activities.collect{|act| [act.subject_id, act.total_points] }
    if score_list.length < count 
      existing_ids = score_list.length.eql?(0) ? [0] : score_list.collect{|score| score.first}
      organizations_no_point = organizations.all(:conditions => "organizations.id not in (#{existing_ids})", :limit => (count - score_list.length))
      organizations_no_point.each{|organization| score_list << [organization.id, 0]}
    end
    return score_list
  end
  
  def has_participant?(user)
    # so that if user is not found it returns nil and not exception
    users.find_by_id(user.id)
  end
  
  def top_users limit = 5
    score_list = Activity.find_by_sql("select sum(points) as total_points, user_id from activities where contest_id=#{self.id} group by user_id order by sum(points) desc limit #{limit}")
  end
  
  def top_organizations limit = 5
    score_list = Activity.find_by_sql("select sum(points) as total_points, subject_id from activities where contest_id=#{self.id} and subject_type='Organization' group by user_id order by sum(points) desc limit #{limit}")
  end
end
