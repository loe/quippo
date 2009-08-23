require File.dirname(__FILE__) + '/../config/environment'

begin
  puts "=> Tracking: #{Quippo.config.twitter[:track].join(", ")}"
  TweetTracker.new.track(*Quippo.config.twitter[:track])
rescue Yajl::ParseError => e
  HoptoadNotifier.notify(e)
  retry
end