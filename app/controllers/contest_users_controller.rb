class ContestUsersController < ApplicationController
  before_filter :login_required
  def create
    contest = Contest.find params[:id]
    contest_user = ContestUser.new :contest => contest, :user => current_user
    flash[]
  end
end