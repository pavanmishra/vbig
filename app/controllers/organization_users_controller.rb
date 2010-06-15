class OrganizationUsersController < ApplicationController
  before_filter :login_required

  def help
    organization = Organization.find(params[:id])
    current_user.help(organization)
    redirect_to organization
  end
  
end