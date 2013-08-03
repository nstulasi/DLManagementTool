class ProjectsController < ApplicationController
    helper_method :sort_column, :sort_direction
    before_filter :require_login
    before_filter :authorize
    delegate :allow?, to: :current_permission
    helper_method :allow?
  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page=>params[:page])
    #Variable open_proejct just stores the name of the currently open project
    @open_project = current_project.name if current_project 
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    cookies.permanent.signed[:open_project] = @project.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project  }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        #Create a Meta object
        @metum = Metum.new
        @metum.project_id=@project.id
        @metum.save!
        
        #Create a membership record
        @project.users<<current_user
        current_user.memberships.first.level=0
        @Projectuser= Membership.where(:project_id=>@project.id, :user_id=>current_user.id)
        @Projectuser.first.level=0
        @Projectuser.first.save!
        
        #Create a designation record
        @designation = Designation.new
        @designation.membership_id=@Projectuser.first.id
        @designation.save!
        
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
        cookies.permanent[:open_project] = @project.id
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    cookies.delete(:open_project)
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
  
  def remove(user)
    current_project.memberships.collect { |u| u.users}  
    current_project.users.delete(current_) #deleting the project the user belongs to
    cookies.delete(:open_project)
    redirect_to projects_path
  end

  private
   def sort_column
    Phase.column_names.include?(params[:sort])? params[:sort] : "name"
   end
   def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
   end
   private
   def require_login
    deny_access unless signed_in?    
   end
end
