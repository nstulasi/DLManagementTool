module ApplicationHelper
  #return title on a per-page basis
  def title
    base_title = "Digital Library  Management Tool"
    if @title.nil?
      base_title
    else
      "#{base_title}|#{@title}"
    end
  end
  def logo
    link_to image_tag("logo.png", :alt=>"Digital library Management Tool", :class =>'round'),projects_path
  end
  
 def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page=>nil), {:class => css_class}
  end
  
  def add_phase_link(name)
      link_to name, "#", "partial" => h(render(:partial => 'phase', :object => Phase.new)), :class => 'phases'
  end
  
  def current_project
    if current_user
      if current_user.projects
        Project.find_by_id(cookies.signed[:open_project])||current_user.projects.first||nil
      end
    else
      nil
    end
  end
  
  def current_membership
    if current_user && current_project
      current_user.memberships.where(:project_id=>current_project.id).first
    end
  end
  
  def phases
    Defaultphase.all
  end
  
  def empty_display(entity)
      ret="<p id='empty_entity'>You have not yet created any "+ entity.to_s.singularize+"#{link_to ". Create it here", :controller=>"#{entity}",:action=>"new"}</p>"
      ret.html_safe
  end
  
  def priority_name(index)
      case index
      
      when 0
         ret = "<a href='#' class='priority' style='background-color: #79B382;'>Lowest</a>"
      when 1
         ret = "<a href='#' class='priority' style='background-color: #79B382;'>Low</a>"
      when 2
         ret = "<a href='#' class='priority' style='background-color: #A89D79;'>Medium</a>"
      when 3
         ret = "<a href='#' class='priority' style='background-color: #9E5454;'>High</a>"
      when 4
         ret = "<a href='#' class='priority' style='background-color: #9E5454;'>Urgent</a>"
      else
         ret = "<font color='red'>Undefined</font>"
      end
  ret.html_safe
   end
   
   def priority_task(index)
      case index
      when 0
         ret = "Lowest"
      when 1
         ret = "Low"
      when 2
         ret = "Medium"
      when 3
         ret = "High"
      when 4
         ret = "Urgent"
      else
         ret = "Undefined"
      end
  ret.html_safe
   end
   
   def priority_task_id(name)
      case name
      when "Lowest"
         ret = 0
      when "Low"
         ret = 1
      when "Medium"
         ret = 2
      when "High"
         ret = 3
      when "Urgent"
         ret = 4
      else
         ret =5
      end
  ret
   end
   
def status_name(index)
      case index     
      when 0
         ret = "Not started"
      when 1
         ret = "In Progress"
      when 2
         ret = "Nearing Completion"
      when 3
          ret = "Completed"
     
      else
         ret = "Undefined"
      end
  ret.html_safe
   end
   
   def status_id(name)
      case name     
      when "Not Started"
         ret = 0
      when "In Progress"
         ret = 1
      when "Nearing Completion"
         ret = 2
      when "Completed"
          ret = 3
     
      else
         ret = 4
      end
  ret
   end
   
 def encodings
   if !current_project.metum.stream_xml.nil?
   @doc = Nokogiri::XML(current_project.metum.stream_xml)
    @encodings=[]
    @checked=[]
    @doc.xpath("//type").each_with_index do |type,index|
      @checked[index]=type.xpath("name").attr('checked')
      @enc=[]
      type.xpath("encoding").each do |e|
         @enc<<e.text
      end
      @encodings[index]={type.xpath("name").text=>@enc}     
    end
    ret=@encodings 
    else
      ret=nil
    end
   end 
    
  def checked
    @checked=[]
    if current_project.nil? || current_project.metum.stream_xml.nil?
      ret=@checked
    else
      @doc = Nokogiri::XML(current_project.metum.stream_xml)
      @doc.xpath("//type").each_with_index do |type,index|
        @checked[index]=type.xpath("name").attr('checked').value
      end
      ret=@checked
    end
  end
  
def sequences
    seq=[]
    
  encodings.each_with_index do |e,i|
  if checked[i].to_bool
    seq<<[encodings[i].keys.first,encodings[i].keys.first]
  end
 end
 ret=seq
 end

def strucs
  if !current_project.nil?
   if !current_project.metum.structure_xml.nil?
   @doc = Nokogiri::XML(current_project.metum.structure_xml)
      if(!@doc.xpath("//collection").empty?)
      ret= Hash.from_xml(@doc.to_s)
      else
        ret=nil
      end
    else
      ret=nil
    end
   else
     ret=nil
  end 
end
 
 def services
  if !current_project.nil?
    if !current_project.metum.scenario_xml.nil?
     @doc = Nokogiri::XML(current_project.metum.scenario_xml)
     @services=[]
     @doc.xpath("//UMLSequenceDiagram").each_with_index do |d,i|
        @services<<d.attr('name')
      end
    ret= @services
   else
     ret=nil
   end
  else
    ret=nil
  end
 end

def soc
  if !current_project.nil?
   if !current_project.metum.society_xml.nil?
   @doc = Nokogiri::XML(current_project.metum.society_xml)
   if(!@doc.xpath("//group").empty?)
    ret= Hash.from_xml(@doc.to_s)
   else 
     ret=nil
   end
    else
      ret=nil
    end
   else
     ret=nil
   end
  end
  
  def soc_checked(i)
    @doc = Nokogiri::XML(current_project.metum.society_xml)
    @checked=[]
    if soc["societies"]["group"].kind_of?(Array)
     params[:id]=soc["societies"]["group"].length+1
    else
     params[:id]=2 
    end 
    soc["societies"]["group"][i]
    @doc.xpath("//type").each_with_index do |type,index|
      @checked[index]=type.xpath("name").attr('checked').value
      @enc=[]
      type.xpath("encoding").each do |e|
         @enc<<e.text
     end
      @encodings[index]={type.xpath("name").text=>@enc}
    end
    ret=@checked
  end
  
   def url_with_protocol(url)
     /^http/.match(url) ? url : "http://#{url}"
   end

end 