class TweetTracker
  require 'yajl/http_stream'
  
  WATCH_EXPRESSION = /(\b|#)qp\b|quippo/
  
  def track(*query, &block)
    query_string = URI.encode(query.join(","))
    
    uri = URI.parse("http://#{Quippo.config.twitter[:login]}:#{Quippo.config.twitter[:password]}@stream.twitter.com/track.json?track=#{query_string}")
    
    loop do
      sleep_count = 0
      sleep_growth = 2
      sleep_cap = 240
      
      Yajl::HttpStream.get(uri, :symbolize_keys => true) do |hash|
        RAILS_DEFAULT_LOGGER.debug "handling quip #{hash[:id]} from user #{hash[:user][:id]}"
      
        if block_given?
          yield hash, query
        else
          if hash.has_key?(:delete)
            delete_quip(hash, query)
          else
            add_quip(hash, query)
          end
        end
      end
      
      HoptoadNotifier.notify(
        {
          :error_class => "Twitter Error", 
          :error_message => "Twitter Error: Disconnected",
        }
      )
      
      s = sleep_count * sleep_growth
      s = sleep_cap if s > sleep_cap
      sleep(s)
      sleep_count += 1
    end
  end
  
  def add_quip(hash, query)
    return if hash[:text] =~ /#fact/
    
    if (user = User.find_by_twitter_id(hash[:user][:id])) && !Quip.exists?(:twitter_id => hash[:id])
      if hash[:text] =~ WATCH_EXPRESSION
        RAILS_DEFAULT_LOGGER.debug "adding quip #{hash[:id]} from user #{hash[:user][:id]}"
        user.quips.create(:twitter_id => hash[:id], :text => Quippo::Sanitizer.sanitize_terms(hash[:text], *query))
      end
    end
  end
  
  def delete_quip(hash, query)
    if q = Quip.find_by_twitter_id(hash[:delete][:status][:id])
      q.destroy
    end
  end
end