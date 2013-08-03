class UsersController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  #before_filter :admin_user , :only => :destroy, :dependent => :destroy
  before_filter :authorize
  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  def new
    @title = "Sign up"
    @user=User.new(:invitation_token => params[:invitation_token])
    @user.email=@user.invitation.recipient_email if @user.invitation
    #Creating a project user if unregistered user needs to be created. 
      1.times do
        membership = @user.memberships.build
        1.times { membership.designations.build } unless params[:project_user].nil?
      end 
  end

  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
    #Returning all users assigned to the currently open project, using the Memberships model as the join
    #The results may contain duplicates as a user may have multiple entries in memberships depending on his roles
    #and responsibilities and so we return unique memberships.
    @proj_users = current_project.users.uniq unless current_project.nil?
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proj_users }
      format.csv { send_data @proj_users.get_csv }
      format.xls
      format.pdf {
        pdf=UserPdf.new(@proj_users,view_context)
        send_data pdf.render, filename: "users.pdf",
                              type: "application/pdf",
                              disposition: "inline"
                              } 
    end 
  end
  
  def show
    @user=User.find(params[:id])
    @title=@user.name
  end
  
  def create
    #Creating/Registering new user
    if params[:project_user].nil?
     @user = User.new(params[:user])
     
     if @user.save 
          signin @user
          cookies.delete(:open_project) 
        flash[:success] = "Welcome to the digital library project management tool. Start by creating a new digital library project"
        redirect_to @user
            
        else
          @title="Sign up"
          render 'new'
      end
     else
    #Creating Project user(Drop-down/new one)
    #if no user is chosen from drop-down
    if params[:user][:id].empty?
      redirect_to :back
      flash[:notice]="Enter user information before saving"
      #puts "bad"
      #sleep(5)
    end
    #Put a conditional ? : statement 
    if params[:project_user]     
          @user=User.find_by_id(params[:user][:id])
          @user.project_user=true
          
          @user.update_attributes params[:user]
          @user.save

         # @Projectuser= Membership.where(:project_id=>current_project.id, :user_id=>@user.id)
         # @Projectuser.first.level=1
          
          redirect_to users_path
      end 
  end#big if
end
  
 def edit
   @user = User.find(params[:id])
   @title = "Edit user"
 end
 

  def update
    @user = User.find(params[:id])
     @user.update_attributes(params[:user])
     respond_with @user

  end
  
  def remove
   @membership=User.find_by_id(params[:userid]).member_of(current_project)
   @membership.delete
   @membership.designations.delete_all
   redirect_to(projects_path)
  end
 
 def admin_user
   redirect_to(root_path) unless current_user.admin?
 end

 private
 def authenticate
   deny_access unless signed_in?
 end
end

  #Useless
  def rake_users
     @errors=[]
    if params[:file].nil?
      @errors<<"Specify an XML file to import"
      flash[:notice]=@errors
    else
      xsd = Nokogiri::XML::Schema(File.read("project-users.xsd"))
      doc = Nokogiri::XML(params[:file].read)
      xsd.validate(doc).each do |error|
          @errors<<error
      end
  
      if !@errors.empty?
        flash[:notice] = @errors
      end

      if !params[:file].nil? && @errors.empty?
        doc.xpath("//user").each do |user|
          name = user.xpath("name").text
          email = user.xpath("email").text
          webpage = user.xpath("webpage").text
          number =  user.xpath("number").text
          
          @user=User.new(:name=>name,:email=>email,:webpage=>webpage,:number=>number)
          @user.project_user=true
          if @user.save
            flash[:notice]="Users created"
          else
            flash[:notice]=@user.errors 
          end
          end
      end
    end
    
    redirect_to :back
  end
  