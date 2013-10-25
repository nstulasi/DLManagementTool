class Permission < Struct.new(:membership)

  def allow?(controller, action,current_user,current_project, id)
   #Did not know what else to do
    if membership.nil?
      return true if controller == "projects" && action.in?(%w[new create index])
      return true if controller == "users" && action.in?(%w[new create index show])
     return true if controller == "users" && action.in?(%w[show]) &&!User.where(:id=>id).first==current_user
      return false
    end
    #If I try to access pages of users/project/... from other projects!
    if id
      return false if controller == "users" && action.in?(%w[show edit delete]) && !User.where(:id=>id).first.member_of(current_project)
      return false if controller == "projects" && action.in?(%w[show edit delete]) && !Project.where(:id=>id).first.member_of(current_user)
    end
    
    if !membership.admin?
      return true if controller == "users" && action.in?(%w[index show])
      #I can only edit my profile regardless of whether I am admin or not
      return false if controller == "users" && action=="edit" && !User.where(:id=>id).first==current_user
      return false if controller == "users" && action=="update" && !User.where(:id=>id).first==current_user
      return true if controller == "projects" && action.in?(%w[index show]) 
      
      return true if controller == "tasks" 
      return true if controller == "events"
      return true if controller == "phases"
      return true
    elsif membership.admin?
       #I can only edit my profile regardless of whether I am admin or not
      #return false if controller == "users" && action=="edit" && User.where(:id=>id).first!=current_user 
      return true
    end
  end
end