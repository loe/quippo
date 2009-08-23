require 'test_helper'

class QuipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :text
  
  context "#filter_attributions!" do
    setup do
      @quip = Quip.new
    end
    
    context "with quote-style text" do
      setup do
        @quip.text = '"The only thing we have to fear, is fear itself." - Franklin D Roosevelt #awesome'
      end
      
      should "set the attribution properly" do
        @quip.filter_attributions!
        assert_equal @quip.attribution, "Franklin D Roosevelt"
      end
      
      should "set the rest of the text back to normal (excluding quotes)" do
        @quip.filter_attributions!
        assert_equal 'The only thing we have to fear, is fear itself. #awesome', @quip.text
      end
    end
    
    context "with parenthetical retweet style text" do
      setup do
        @quip.text = <<-LOL
Arbor Day

#boringdisastermovie (via @sween)
LOL
      end
      
      should "set the attribution properly" do
        @quip.filter_attributions!
        assert_equal @quip.attribution, "@sween"
      end
      
      should "set the rest of the text back to normal" do
        @quip.filter_attributions!
        
        expected = "Arbor Day #boringdisastermovie"
        assert_equal expected, @quip.text
      end
    end
    
    context "with prefix retweet style text" do
      setup do
        @quip.text = "RT @texel_quippo_2: hi quippo! #awesome"
      end

      should "set the attribution properly" do
        @quip.filter_attributions!
        assert_equal @quip.attribution, "@texel_quippo_2"
      end

      should "set the rest of the text back to normal" do
        @quip.filter_attributions!

        expected = "hi quippo! #awesome"
        assert_equal expected, @quip.text
      end
    end
  end
end