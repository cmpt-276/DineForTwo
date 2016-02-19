require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "Dine for Two"
  end

  test "should get home" do
    get :home # A controller action.
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
    # Selects the title tag and asserts it matches the given string
  end
  
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end
