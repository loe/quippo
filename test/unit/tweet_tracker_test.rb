require 'test_helper'

class TweetTrackerTest < ActiveSupport::TestCase
  context "#add_quip" do
    setup do
      @user = Factory.create(:user)
      @tracker = TweetTracker.new
    end

    context "with a hash from a user which has none of the watch words" do
      setup do
        @tweet_hash = {
          :id => @user.id,
          :text => "I am a tweet!", 
          :user => {
            :screen_name => @user.twitter_screen_name, 
            :name => @user.twitter_name,
            :profile_image_url => "http://quippo.com/images/1", 
            :notifications => nil, 
            :id => 12345, 
          }
        }
      end

      should "not add a quip" do
        quips_before = Quip.count
        @tracker.add_quip(@tweet_hash)
        assert quips_before == Quip.count
      end
    end
    
    context "with a hash from a user which has a watch word" do
      setup do
        @tweet_hash = {
          :id => @user.id,
          :text => "I am a tweet! #qp", 
          :user => {
            :screen_name => @user.twitter_screen_name, 
            :name => @user.twitter_name,
            :profile_image_url => "http://quippo.com/images/1", 
            :notifications => nil, 
            :id => 12345, 
          }
        }
      end

      should "add a quip" do
        quips_before = Quip.count
        @tracker.add_quip(@tweet_hash)
        assert quips_before + 1 == Quip.count
      end
    end
    
    context "with a hash from a non-user which has none of the watch words" do
      setup do
        @tweet_hash = {
          :id => 11111,
          :text => "I am a tweet!", 
          :user => {
            :screen_name => 'some_dude', 
            :name => 'Some Dude',
            :profile_image_url => "http://quippo.com/images/2", 
            :notifications => nil, 
            :id => 12346, 
          }
        }
      end

      should "not add a quip" do
        quips_before = Quip.count
        @tracker.add_quip(@tweet_hash)
        assert quips_before == Quip.count
      end
    end
    
    context "with a hash from a user which has a watch word" do
      setup do
        @tweet_hash = {
          :id => 11111,
          :text => "I am a tweet! #qp", 
          :user => {
            :screen_name => 'some_dude', 
            :name => 'Some Dude',
            :profile_image_url => "http://quippo.com/images/2", 
            :notifications => nil, 
            :id => 12346, 
          }
        }
      end

      should "not add a quip" do
        quips_before = Quip.count
        @tracker.add_quip(@tweet_hash)
        assert quips_before == Quip.count
      end
    end
    
  end
  
end