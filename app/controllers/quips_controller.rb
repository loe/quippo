class QuipsController < ApplicationController
  before_filter :get_user
  
  def index
    search_hash = {}
    search_hash[:text_search] = params[:q].split(/\s|,/) if params[:q]
    
    @quips = (@user.try(:quips) || Quip).descending.search(search_hash.merge(:include => :user, :page => params[:page]))
    
    respond_to do |wants|
      wants.html {  }
      wants.js {  }
      wants.json { render :json => @quips.to_json }
    end
  end
  
  def show
    if params[:id] == 'random'
      @quips = (@user.try(:quips) || Quip).random.paginate(:all, :page => nil, :per_page => 1, :include => :user)
    else
      @quips = (@user.try(:quips) || Quip).paginate(:all, :page => nil, :per_page => 1, :conditions => {:id => params[:id]})
    end
    
    respond_to do |wants|
      wants.html { render :action => 'index' }
      wants.json { render :json => @quips.to_json }
    end
  end
  
  protected
  
  def get_user
    if params[:user_id]
      redirect_to(root_url) unless @user = User.find_by_twitter_screen_name(params[:user_id])
    end
  end
end
