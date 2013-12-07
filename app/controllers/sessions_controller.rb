class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
    respond_to do |format|
           format.html # new.html.erb
           format.json { render json: @user }
  end
end
 
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
   if user.nil?
     flash.now[:error]= "Invalid email/password combination."
     @title = "Sign in"
     render 'new'
  else
    sign_in user
    redirect_back_or user
  end                                  
  end
  

  def destroy
    sign_out 
    redirect_to root_path
  end
end
