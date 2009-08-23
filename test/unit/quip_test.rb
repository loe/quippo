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
    end
  end
end
