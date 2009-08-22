class TweetTracker
  require 'yajl/http_stream'
  
  WATCH_EXPRESSION = /(\b|#)qp\b|quippo/
  
  def track(*query, &block)
    query_string = URI.encode(query.join(","))
    
    uri = URI.parse("http://#{Quippo.config.twitter[:username]}:#{Quippo.config.twitter[:password]}@stream.twitter.com/track.json?track=#{query_string}")
    Yajl::HttpStream.get(uri, :symbolize_keys => true) do |hash|
      RAILS_DEFAULT_LOGGER.debug "handling quip #{hash[:id]} from user #{hash[:user][:id]}"
      
      if block_given?
        yield hash, query
      else
        add_quip(hash, query)
      end
    end
  end
  
  def add_quip(hash, query)    
    if (user = User.find_by_twitter_id(hash[:user][:id])) && !Quip.exists?(:twitter_id => hash[:id])
      if hash[:text] =~ WATCH_EXPRESSION
        RAILS_DEFAULT_LOGGER.debug "adding quip #{hash[:id]} from user #{hash[:user][:id]}"
        user.quips.create(:twitter_id => hash[:id], :text => Quippo::Sanitizer.sanitize_terms(hash[:text], *query))
      end
    end
  end
end