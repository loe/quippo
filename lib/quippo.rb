module Quippo
  def self.generate_twitter_client
    TwitterOAuth::Client.new(
      :consumer_key => self.config.twitter[:key],
      :consumer_secret => self.config.twitter[:secret]
    )
  end
end