class PagesController < ApplicationController
  
  def show
    @page = Page.find(:first, :conditions => {:name => params[:name]})
    raise ActiveRecord::RecordNotFound
  end
  
end