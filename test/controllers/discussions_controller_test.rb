require 'test_helper'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user= users(:one)
    @channel = channels(:one)
    @discussion = discussions(:one)
    sign_in @user
  end

  test "should get edit" do
    get edit_discussion_url(@discussion)
    assert_response :success
  end

  test "should destroy discussion" do
    assert_difference('Discussion.count', -1) do
      delete discussion_url(@discussion)
    end

    assert_redirected_to discussions_url
  end

end
