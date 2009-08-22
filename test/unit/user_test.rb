require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :twitter_atoken, :twitter_asecret
  
  context "#seed_info" do
    setup do 
      @user   = User.new
      @token  = OpenStruct.new :token => 'token', :secret => 'secret'
      @info   = {'id' => 1234, 'screen_name' => 'texel', 'name' => 'Leigh Caplan', 'foobar' => 'baz'}
    end    
    
    should "not raise an error" do
      assert_nothing_raised { @user.seed_info(@token, @info) }
    end
    
    should "set the twitter_atoken" do
      @user.seed_info(@token, @info)
      assert @user.twitter_atoken == @token.token
    end
    
    should "set the twitter_asecret" do
      @user.seed_info(@token, @info)
      assert @user.twitter_asecret == @token.secret
    end
    
    should "set the relevant twitter info" do
      @user.seed_info(@token, @info)
      @info.each do |key, value|
        assert @user.send(:"twitter_#{key}") == value if @user.respond_to?(:"twitter_#{key}")
      end
    end
  end
end