class QuipsController < ApplicationController
  before_filter :get_user
  
  def index
    if @user
      @quips = @user.quips.all(:order => 'id DESC').paginate
    else
      @quips = Quip.all(:order => 'id DESC').paginate
    end
    
    respond_to do |wants|
      flash.now[:notice] = "oh hi there"
      wants.html {  }
    end
  end
  
  protected
  
  def get_user
    if params[:user_id]
      redirect_to(root_url) and return false unless @user = User.find_by_twitter_screen_name(params[:user_id])
    end
  end
end
