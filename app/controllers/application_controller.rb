# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  include AuthenticatedSystem
  
  protected
  
  def admin_required
    unless current_user.is_admin?
      flash[:notice] = 'You need to be admin, to perform this action'
      redirect_to root_path and return
    end
    return true
  end
  
  def process_params_for_tags item_name, tag_name
    tag_name_plural = tag_name.pluralize
    params[tag_name_plural] ||= []
    return params[item_name][tag_name + '_list'] = params['other_' + tag_name_plural] + ',' + params[tag_name_plural].join(',') unless params['other_' + tag_name_plural].empty? and params[tag_name_plural].empty?
    return params[item_name][tag_name + '_list'] = params['other_' + tag_name_plural] unless params['other_' + tag_name_plural].empty?
    return params[item_name][tag_name + '_list'] = params[tag_name_plural].join(',') unless params[tag_name_plural].empty?
  end
    
end
