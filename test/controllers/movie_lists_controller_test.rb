require 'test_helper'

class MovieListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movie_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get movie_lists_show_url
    assert_response :success
  end

  test "should get create" do
    get movie_lists_create_url
    assert_response :success
  end

  test "should get update" do
    get movie_lists_update_url
    assert_response :success
  end

  test "should get destroy" do
    get movie_lists_destroy_url
    assert_response :success
  end

end
