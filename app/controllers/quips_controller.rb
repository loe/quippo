class QuipsController < ApplicationController
  before_filter :get_user
  
  def index
    if @user
      @quips = @user.quips.paginate(:page => params[:page], :order => 'id DESC')
    else
      @quips = Quip.paginate(:include => :user, :page => params[:page], :order => 'id DESC')
    end
    
    respond_to do |wants|
      wants.html {  }
      wants.js {  }
    end
  end
  
  protected
  
  def get_user
    if params[:user_id]
      redirect_to(root_url) and return false unless @user = User.find_by_twitter_screen_name(params[:user_id])
    end
  end
end
