require File.dirname(__FILE__) + '/../config/environment'

TweetTracker.new.track(Quippo.config.twitter[:track])