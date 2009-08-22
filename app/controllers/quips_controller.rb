class QuipsController < ApplicationController
  def index
    if current_user
      @quips = current_user.quips.all(:order => 'id DESC').paginate
    else
      @quips = Quip.all(:order => 'id DESC').paginate
    end
    
    respond_to do |wants|
      wants.html {  }
    end
  end
end
