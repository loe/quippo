TWITTER_CREDENTIALS = HashWithIndifferentAccess.new(YAML.load(File.read("#{RAILS_ROOT}/config/twitter.yml")))