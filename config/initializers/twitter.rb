module Quippo
  mattr_accessor :config
  
  self.config = OpenStruct.new unless self.config
  self.config.twitter = HashWithIndifferentAccess.new(YAML.load(File.read("#{RAILS_ROOT}/config/twitter.yml"))[RAILS_ENV])
end