require 'test_helper'

class PhotoNewsControllerTest < ActionController::TestCase
  test "should get title_photo_news_list" do
    get :title_photo_news_list
    assert_response :success
  end

  test "should get detail_photo_news_view" do
    get :detail_photo_news_view
    assert_response :success
  end

end
