class User < ActiveRecord::Base
  has_many :quips
  
  validates_presence_of :twitter_atoken, :twitter_asecret
end
