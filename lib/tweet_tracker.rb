class TweetTracker
  require 'yajl/http_stream'
  
  def track(*query)
    query_string = URI.encode(query.join(","))
    
    uri = URI.parse("http://#{Quippo.config.twitter[:username]}:#{Quippo.config.twitter[:password]}@stream.twitter.com/track.json?track=#{query_string}")
    Yajl::HttpStream.get(uri, :symbolize_keys => true) do |hash|
      puts hash.inspect
    end
  end
end