require File.dirname(__FILE__) + '/../config/environment'

begin
  puts "=> Tracking: #{Quippo.config.twitter[:track].join(", ")}"
  TweetTracker.new.track(Quippo.config.twitter[:track])
rescue YAJL::ParserError => e
  puts "Encountered a YAJL::ParserError: #{e.message}"
  retry
end
