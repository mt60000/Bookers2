require 'test_helper'

class UsesControllerTest < ActionDispatch::IntegrationTest
  test "should get controller" do
    get uses_controller_url
    assert_response :success
  end

  test "should get index" do
    get uses_index_url
    assert_response :success
  end

  test "should get show" do
    get uses_show_url
    assert_response :success
  end

  test "should get edit" do
    get uses_edit_url
    assert_response :success
  end

end
