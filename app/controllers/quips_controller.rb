class QuipsController < ApplicationController
  before_filter :get_user, :prepare_search
  
  def index
    @quips = (@user.try(:quips) || Quip).descending.search(@search_hash.merge(:include => :user, :page => params[:page]))
    
    respond_to do |wants|
      wants.html {  }
      wants.js {  }
      wants.json { render :json => @quips.to_json }
    end
  end
  
  def show
    if params[:id] == 'random'
      @quips = (@user.try(:quips) || Quip).search_for(@search_hash).random.paginate(:all, :page => nil, :per_page => 1, :include => :user)
    else
      @quips = (@user.try(:quips) || Quip).search_for(@search_hash).paginate(:all, :page => nil, :per_page => 1, :conditions => {:id => params[:id]})
    end
    
    respond_to do |wants|
      wants.html { render :action => 'index' }
      wants.json { render :json => @quips.to_json }
    end
  end

  # GET /quips/1/edit
  def edit    
    @quip = Quip.find(params[:id])
  end

  # PUT /quips/1
  # PUT /quips/1.xml
  def update
    @quip = Quip.find(params[:id])

    respond_to do |format|
      if @quip.update_attributes(params[:quip])
        format.js   { render :json => @quip }
        format.xml  { head :ok }
      else
        format.js   { render :json => @quip }
        format.xml  { render :xml => @quip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quips/1
  # DELETE /quips/1.xml
  def destroy
    @quip = Quip.find(params[:id])
    @quip.destroy

    respond_to do |format|
      format.html { redirect_to(quips_url) }
      format.xml  { head :ok }
    end
  end

  protected
  
  def get_user
    if params[:user_id]
      redirect_to(root_url) unless @user = User.find_by_twitter_screen_name(params[:user_id])
    end
  end
  
  def prepare_search
    @search_hash = {}
    @search_hash[:text_search] = params[:q].split(/\s|,/) if params[:q].present?
  end
end
