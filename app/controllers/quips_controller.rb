class QuipsController < ApplicationController
  def index
    if current_user
      @quips = current_user.quips.all.paginate
    else
      @quips = Quip.all.paginate
    end
    
    respond_to do |wants|
      wants.html {  }
    end
  end
end
