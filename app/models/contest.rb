class Contest < ActiveRecord::Base
  has_many :contest_users
  has_many  :users, :through => :contest_users
  has_many  :contest_organizations
  has_many  :organizations, :through => :contest_organizations
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  has_attached_file :image, :path => ':rails_root/public/system/images/contests/:attachment/:id/:style/:filename', 
        :url => '/system/images/contests/:attachment/:id/:style/:filename',
        :styles => {
          :small_thumbnail => "75x79#",
          :smaller_thumbnail => "60x60#",
          :thumb=> "100x100#",
          :small  => "150x150>",
          :medium => "200x200#",
          :large =>   "400x400>"
        }
  # used by will_paginate
  cattr_reader :per_page
  @@per_page = 10
  
  def has_participant?(user)
    users.find(user.id)
  end
end
