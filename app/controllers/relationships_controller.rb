class RelationshipsController<ApplicationController
  before_filter :authenticate
  #  
  # def create
  #  
  # 
  #   user =User.find(params[:relationship][:followed_id])
  #   current_user.follow!(@user)
  #   respond_to do |format|
  #       format.html { redirect_to @user }
  #       format.js
  #     end
  # end
  # 
  def create
    @followed = User.find(params[:id])
    current_user.follow!(@followed)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js { @user = @followed}
    end
  end
  
  def destroy
    @unfollowed=Relationship.find(params[:id]).followed
    
    # user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@unfollowed)
    respond_to do |format|
    format.js { @user = @unfollowed}
    
  end
  
  # 
  # def create
  #     @user = User.find(params[:relationship][:followed_id])
  #     current_user.follow!(@user)
  #     respond_to do |format|
  #       format.html { redirect_to @user }
  #       format.js
  #     end
  #   end
  # 
  #   def destroy
  #     @user = Relationship.find(params[:id]).followed
  #     current_user.unfollow!(@user)
  #     respond_to do |format|
  #       format.html { redirect_to @user }
  #       format.js
  #     end
  #   end
  end
  
end