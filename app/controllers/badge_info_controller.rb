class BadgeInfoController < ApplicationController
  include FaceboxRender
  
  def show
    @badge_url = params[:badge_url]
        
    respond_to do |wants|
      wants.js { render_to_facebox :action => params[:id] }
    end
  end
end