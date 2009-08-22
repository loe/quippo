class AuthorizationsController < ApplicationController
  before_filter :generate_client
  before_filter :verify_oauth, :only => [:index]
  
  def new
    @request_token = @client.request_token(:oauth_callback => Quippo.config.twitter[:confirm_url])
    
    # store the request token in the session, for authorization
    session[:twitter_request_token] = {
      :token  => @request_token.token,
      :secret => @request_token.secret
    }
    
    respond_to do |wants|
      wants.html { redirect_to @request_token.authorize_url }
    end
  end
  
  def index
    @access_token = @client.authorize(
      @request_token.token,
      @request_token.secret,
      :oauth_verifier => params[:oauth_token]
    )
    
    if @client.authorized?
      # This user has a one-way ticket to awesometown.
      @info = @client.info
      @user = User.find_or_create_by_twitter_id(@info['id'])
      
      @user.seed_info(@access_token, @info)
      @user.save
      
      # Store the user id in the session
      session[:user_id] = @user.id
      
      flash[:notice] = "Welcome, #{@user.twitter_screen_name}!"
    else
      # Oh no something bad happened :(
      flash[:error] = "We were unable to log you in. Sorry!"
    end
    
    respond_to do |wants|
      wants.html { redirect_to user_quips_url(@user) }
    end
  end
  
  def destroy
    session[:user_id] = nil
    respond_to do |wants|
      wants.html { redirect_to quips_url }
    end
  end
  
  protected
  
  def generate_client
    @client = Quippo.generate_twitter_client
  end
  
  def verify_oauth
    redirect_to quips_url and return false unless params[:oauth_token] && 
      session[:twitter_request_token] && 
      @request_token = unfreeze_request_token
  end
  
  def unfreeze_request_token
    token = OAuth::RequestToken.new :oauth_callback => Quippo.config.twitter[:confirm_url]
    token.token   = session[:twitter_request_token][:token]
    token.secret  = session[:twitter_request_token][:secret]
    token
  end
end