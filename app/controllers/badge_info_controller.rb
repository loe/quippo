class BadgeInfoController < ApplicationController
  include FaceboxRender
  
  def show
    @url = params[:url]
    
    respond_to do |wants|
      wants.js { render_to_facebox :partial => params[:id] }
    end
  end
end