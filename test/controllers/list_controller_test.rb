require 'test_helper'

class ListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get list_index_url
    assert_response :success
  end

  test "should get new" do
    get list_new_url
    assert_response :success
  end

  test "should get create" do
    get list_create_url
    assert_response :success
  end

  test "should get show" do
    get list_show_url
    assert_response :success
  end

  test "should get update" do
    get list_update_url
    assert_response :success
  end

  test "should get destroy" do
    get list_destroy_url
    assert_response :success
  end

end
