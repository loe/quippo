class QuipsController < ApplicationController
  before_filter :get_user, :prepare_search, :get_badge_url
  before_filter :load_quip, :only => [:update, :destroy]
  
  def index
    @quips = (@user.try(:quips) || Quip).descending.search(@search_hash.merge(:include => :user, :page => params[:page]))
    
    respond_to do |wants|
      wants.html {  }
      wants.js {  }
      wants.json { render :json => @quips.to_json(:include => :user) }
    end
  end
  
  def show
    if params[:id] == 'random'
      @quips = (@user.try(:quips) || Quip).random.search(@search_hash.merge(:include => :user, :limit => 1, :page => nil))
    else
      @quips = (@user.try(:quips) || Quip).find_all_by_id(params[:id])
    end
    
    respond_to do |wants|
      wants.html { render :action => 'index' }
      wants.json { render :json => @quips.to_json(:include => :user) }
    end
  end
  
  def update
    respond_to do |format|
      if @quip.update_attributes(params[:quip])
        format.js   { render :json => @quip }
      else
        format.js   { render :json => @quip }
      end
    end
  end
  
  def destroy
    @quip.destroy

    respond_to do |format|
      format.html { redirect_to(quips_path) }
    end
  end

  protected
  
  def get_user
    if params[:user_id]
      redirect_to(root_path) unless @user = User.find_by_twitter_screen_name(params[:user_id])
    end
  end
  
  def load_quip
    redirect_to quip_path unless @quip = current_user.quips.find(params[:id])
  end
  
  def prepare_search
    @search_hash = {}
    @search_hash[:text_search] = params[:q].split(/\s|,/) if params[:q].present?
  end
  
  def get_badge_url
    @badge_url = url_for(:id => 'random', :format => 'json', :q => params[:q], :action => 'show', :callback => '10101', :controller => 'quips', :user_id => @user, :only_path => false).gsub(/10101/, '?')
  end
end
