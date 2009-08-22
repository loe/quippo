class TweetTracker
  require 'yajl/http_stream'
  
  WATCH_EXPRESSION = /(\b|#)qp\b|quippo/
  
  def track(*query)
    query_string = URI.encode(query.join(","))
    
    uri = URI.parse("http://#{Quippo.config.twitter[:username]}:#{Quippo.config.twitter[:password]}@stream.twitter.com/track.json?track=#{query_string}")
    Yajl::HttpStream.get(uri, :symbolize_keys => true) do |hash|
      add_quip(hash)
    end
  end
  
  def add_quip(hash)
    if (user = User.find_by_twitter_id(hash[:user][:id])) && !Quip.exists?(:twitter_id => hash[:id])
      user.quips.create(:twitter_id => hash[:id], :text => hash[:text]) if hash[:text] =~ WATCH_EXPRESSION
    end
  end
end