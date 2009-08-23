Factory.define :user do |u|
  u.twitter_id 12345
  u.twitter_screen_name 'joeblow'
  u.twitter_name 'Joseph Blow'
  u.twitter_atoken 'abcd'
  u.twitter_asecret 'efgh'
end

Factory.define :quip do |q|
  q.twitter_id 12345
  q.text 'ahhhhhhhhhhhhhh'
  q.user_id 12345
end