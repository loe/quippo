require File.dirname(__FILE__) + '/../config/environment'

puts "=> Tracking: #{Quippo.config.twitter[:track].join(", ")}"

loop do
  sleep_count = 0
  sleep_growth = 2
  sleep_cap = 240

  begin
    TweetTracker.new.track(*Quippo.config.twitter[:track])
  rescue Yajl::ParseError => e
    HoptoadNotifier.notify(e)
    retry
  end

  HoptoadNotifier.notify(
    {
      :error_class => "Twitter Error", 
      :error_message => "Twitter Error: Disconnected"
    }
  )

  s = sleep_count * sleep_growth
  s = sleep_cap if s > sleep_cap
  sleep(s)
  sleep_count += 1
  
  if sleep_count > 100
    e = RuntimeError("Twitter is fubar.")
    HoptoadNotifier.notify(e)
    raise e
  end
end