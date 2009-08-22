config = HashWithIndifferentAccess.new(YAML.load(File.read("#{RAILS_ROOT}/config/twitter.yml")))

TWITTER_CREDENTIALS = config[RAILS_ENV]