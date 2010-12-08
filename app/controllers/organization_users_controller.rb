class OrganizationUsersController < ApplicationController
  before_filter :login_required

  def help

    organization = Organization.find(params[:id])
    unless current_user.helping?(organization)
      current_user.help(organization) 
      flash[:notice] = 'You are now helping this organization'
    else
        flash[:notice] = 'You are already helping this organization'
    end
    redirect_to request.referrer =~ /contest/ ? request.referrer : organization
  end
  
end