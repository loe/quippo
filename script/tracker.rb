require File.dirname(__FILE__) + '/../config/environment'

puts "=> Tracking: #{Quippo.config.twitter[:track].join(", ")}"
TweetTracker.new.track(Quippo.config.twitter[:track])