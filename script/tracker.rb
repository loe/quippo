require File.dirname(__FILE__) + '/../config/environment'

begin
  puts "=> Tracking: #{Quippo.config.twitter[:track].join(", ")}"
  TweetTracker.new.track(Quippo.config.twitter[:track])
rescue Yajl::ParserError => e
  puts "Encountered a Yajl::ParserError: #{e.message}"
  retry
end