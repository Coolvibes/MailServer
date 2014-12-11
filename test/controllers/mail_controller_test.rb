require 'test_helper'

class MailControllerTest < ActionController::TestCase
  test "should get compose" do
    get :compose
    assert_response :success
  end

end
