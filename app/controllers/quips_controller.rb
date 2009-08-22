class QuipsController < ApplicationController
  def index
    @quips = (1..10).map do |i|
      Quip.new :text => "Quip #{i + 1}"
    end
    
    respond_to do |wants|
      wants.html {  }
    end
  end
end
