class ApplicationController < ActionController::Base
  before_filter :authenticate_user
  
  helper :all

  protect_from_forgery

  include HoptoadNotifier::Catcher
  
  protected
  
  def authenticate_user
    current_user
  end
  
  def current_user
    @current_user ||= session[:user_id] ? User.find_by_id(session[:user_id]) : nil
  end
  helper_method :current_user
end
