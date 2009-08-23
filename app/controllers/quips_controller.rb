class QuipsController < ApplicationController
  before_filter :get_user
  
  def index
    @quips = (@user.try(:quips) || Quip).descending.all.paginate
    
    respond_to do |wants|
      wants.html {  }
      wants.json { render :json => @quips.to_json }
    end
  end
  
  def show
    if params[:id] == 'random'
      @quips = (@user.try(:quips) || Quip).random.find(:all, :limit => 1)
    else
      @quips = (@user.try(:quips) || Quip).find(params[:id])
    end
    
    respond_to do |wants|
      wants.html { render :action => 'index' }
      wants.json { render :json => @quips.to_json }
    end
  end
  
  def method_name
    
  end
  
  protected
  
  def get_user
    if params[:user_id]
      redirect_to(root_url) and return false unless @user = User.find_by_twitter_screen_name(params[:user_id])
    end
  end
end
