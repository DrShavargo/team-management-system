require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get router" do
    get :router
    assert_response :success
  end

  test "should get email_confirm_required" do
    get :email_confirm_required
    assert_response :success
  end

end
