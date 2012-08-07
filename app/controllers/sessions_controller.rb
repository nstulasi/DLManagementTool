class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if(user.nil?)
      flash[:notice] = "Invalid email and password combination"
      @title = "Sign in"
      redirect_to root_path
     else
       signin user
       redirect_back_or user
     end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
