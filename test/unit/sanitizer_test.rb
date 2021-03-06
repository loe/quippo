require 'test_helper'

class SanitizerTest < ActiveSupport::TestCase
  context ".sanitize_terms" do
    setup do
      @terms    = %w(qp quippo)
      @string   = "@quippo @other I have a qp awesome quip for you @quippopotamus #other #qp #other2 #quippo"
    end

    should "remove hashtags for search terms only" do
      output = Quippo::Sanitizer.sanitize_terms(@string, *@terms)
      assert_equal output, "@quippo @other I have a qp awesome quip for you @quippopotamus #other #other2"
    end
  end
  
  
end
