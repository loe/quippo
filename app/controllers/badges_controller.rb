class BadgesController < ApplicationController
  def show
    respond_to do |wants|
      wants.js { render :action => params[:id] }
    end
  end
end