require 'test_helper'

class MapResultsControllerTest < ActionController::TestCase
  test "should get results" do
    get :results
    assert_response :success
  end

end
