require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :twitter_atoken, :twitter_asecret
end
