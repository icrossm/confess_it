class UsersController < ApplicationController
  before_filter :authenticate ,:except => [:show,:new,:create]
    before_filter :correct_user ,:only => [:edit,:update]
     before_filter :admin_user,:only => :destroy
    def index 
      @user=User.paginate(page: params[:page], per_page: 20) 
      @title="All users"
    end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 20) 
    @title =@user.name  
    
  end  
  
  def following
    @title ="Following"
    @user = User.find(params[:id])
    @users=@user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title ="Followers"
    @user = User.find(params[:id])
    @users=@user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  
  def new
    @user  = User.new
    @title ="Sign Up"
  end
  
  def create
    
     @user=User.new(params[:user])
    if  @user.save
      sign_in @user
      
      flash[:success]="Welcome !"
      
       redirect_to @user
      
    else  
     @title="Sign up"
      render 'new'
  end
end
  def edit 
    
    @title="Edit User"
end

def update

  if @user.update_attributes(params[:user])
    redirect_to @user ,:flash =>{:success => "Profile updated"}
  else
  @title="Edit User"
  render 'edit'
end
end

def destroy
  @user.destroy
  flash[:success]= "User Deleted"
  
  redirect_to users_path
end 
private

  
   
   def correct_user
     @user = User.find(params[:id])
     redirect_to(root_path) unless current_user?(@user)
   end
   
   def admin_user
      @user = User.find(params[:id])
     redirect_to root_path if !current_user.admin? || current_user?(@user)
   end
end