module UsersHelper

  def current_project_users
    current_project.users do |d|
       return Array[d]    
    end
  end
  def display_users(users)
           ret = '<ul CLASS ="mktree">'
     for category in categories
       if category.parent_id == nil
      ret += "<li>"
      ret += link_to category.name, category
      ret += "&nbsp;&nbsp;"
      

      if category.children.size >0 && category_owner_children(category) == 1
       ret += find_all_subcategories(category)
       end
      ret += "</li>"
    
       end
       
     end
     ret += "</ul>"
     ret.html_safe
    end
end
