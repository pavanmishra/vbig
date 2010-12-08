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
  
  def has_participant?(user)
    # so that if user is not found it returns nil and not exception
    users.find_by_id(user.id)
  end
end
