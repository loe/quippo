class AuthorizationsController < ApplicationController
  before_filter :generate_client
  before_filter :verify_oauth, :only => [:index]
  
  def new
    @request_token = client.request_token(:oauth_callback => Quippo.config.twitter[:confirm_url])
    
    # store the request token in the session, for authorization
    session[:twitter_request_token] = request_token
    
    respond_to do |wants|
      wants.html { redirect_to request_token.authorize_url }
    end
  end
  
  def index
    @access_token = @client.authorize(
      @request_token.token,
      @request_token.secret,
      :oauth_verifier => params[:oauth_token]
    )
    
    respond_to do |wants|
      if @client.authorized?
        # This user has a one-way ticket to awesometown.
        @info = @client.info
        @user = User.find_or_create_by_twitter_id(@info['id'])
        
        @user.twitter_atoken    = @access_token.token
        @user.twitter_stoken    = @access_token.secret
        @user.twitter_username  = @info['screen_name']
      else
        # Oh no something bad happened :(
        flash[:error] = "We were unable to log you in. Sorry!"
        wants.html { redirect_to quips_url }
      end
    end
  end
  
  protected
  
  def generate_client
    @client = Quippo.generate_twitter_client
  end
  
  def verify_oauth
    redirect_to quips_url and return false unless params[:oauth_token] && @request_token = session[:twitter_request_token]
  end
end