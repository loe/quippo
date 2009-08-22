require 'test_helper'

class SanitizerTest < ActiveSupport::TestCase
  context ".sanitize_terms" do
    setup do
      @terms    = %w(qp quippo)
      @string   = "@quippo @other I have a qp awesome quip for you #other #qp #other2 #quippo"
    end

    should "remove hashtags and @replies for search terms only" do
      output = Quippo::Sanitizer.sanitize_terms(@string, *@terms)
      assert_equal output, "@other I have a qp awesome quip for you #other #other2"
    end
  end
  
  
end
