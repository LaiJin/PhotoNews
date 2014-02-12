require 'test_helper'

class ImageUploadControllerTest < ActionController::TestCase
  test "should get image_upload_view" do
    get :image_upload_view
    assert_response :success
  end

  test "should get image_show_view" do
    get :image_show_view
    assert_response :success
  end

end
