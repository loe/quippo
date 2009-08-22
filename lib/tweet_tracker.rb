class TweetTracker
  require 'yajl/http_stream'
  
  def track(*query)
    query_string = URI.encode(query.join(","))
    
    uri = URI.parse("http://#{TWITTER_CREDENTIALS[:username]}:#{TWITTER_CREDENTIALS[:password]}@stream.twitter.com/track.json?track=#{query_string}")
    Yajl::HttpStream.get(uri, :symbolize_keys => true) do |hash|
      puts hash.inspect
    end
  end
end