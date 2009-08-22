class ApplicationController < ActionController::Base
  before_filter :authenticate_user
  
  helper :all

  protect_from_forgery

  include HoptoadNotifier::Catcher
  
  protected
  
  def authenticate_user
    @current_user = User.find_by_id(session[:user_id])
  end
  
  def current_user
    @current_user
  end
  helper_method :current_user
end
