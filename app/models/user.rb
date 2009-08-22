class User < ActiveRecord::Base
  has_many :quips
  
  validates_presence_of :twitter_atoken, :twitter_asecret
  
  def seed_info(token, info={})
    self.twitter_atoken   = token.token
    self.twitter_asecret  = token.secret
    
    info.each do |key, value|
      self.send(:"twitter_#{key}=", value) if self.respond_to?(:"twitter_#{key}=")
    end
  end
  
  def to_param
    twitter_screen_name
  end
end
