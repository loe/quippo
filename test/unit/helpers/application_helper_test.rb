require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  attr_accessor :current_user
  
  context "#identify_user" do
    should "say 'your' if the current user is the same" do
      @current_user = @user = Factory.create(:user)
      
      assert 'your' == identify_user(@user)
    end
    
    should "say 'the public' if the user is nil" do
      @current_user = Factory.create(:user)
      @user = nil
      assert 'the public' == identify_user(@user)
    end
    
    should "say other users name otherwise" do
      @current_user = Factory.create(:user, :twitter_id => 1)
      @user = Factory.create(:user, :twitter_id => 2, :twitter_screen_name => 'bob')
      assert "bob's" == identify_user(@user)
    end
  end
  
end
