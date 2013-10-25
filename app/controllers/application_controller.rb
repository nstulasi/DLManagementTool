class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include TasksHelper
  include UsersHelper
  include EventsHelper
  include ApplicationHelper
  include PhasesHelper
  include MetaHelper
  
  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  private
   def current_permission
     Permission.new(current_membership)
   end
   
   def authorize
       if !current_permission.allow?(params[:controller], params[:action],current_user, current_project,params[:id])
        #if current_user && current_project && !current_membership.admin?
        redirect_to projects_url, alert: "You are not authorized to perform this action"
      end
    end
end
