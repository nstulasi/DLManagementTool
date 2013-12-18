class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    
    @invitation.sender=current_user
    if @invitation.save
        if !current_user.nil?
        Mailer.invitation(@invitation, signup_url(:invitation_token=>@invitation.token)).deliver
        puts signup_url
        puts @invitation.token
        puts signup_url(@invitation.token)
      #sleep(5)
        flash[:notice] = "Thank you, invitation sent."
        redirect_to users_url
      else
        flash[:notice] = "Thank you, we will notify when we are ready."
        redirect_to users_url
      end
    else
      render :action => 'new'
    end
  end
end
