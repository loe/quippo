require File.dirname(__FILE__) + '/../config/environment'

begin
  TweetTracker.new.track(Quippo.config.twitter[:track])
rescue YAJL::ParserError => e
  puts "Encountered a YAJL::ParserError: #{e.message}"
  retry
end