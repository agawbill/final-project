require 'test_helper'

class MovieSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movie_search_index_url
    assert_response :success
  end

  test "should get show" do
    get movie_search_show_url
    assert_response :success
  end

  test "should get create" do
    get movie_search_create_url
    assert_response :success
  end

  test "should get update" do
    get movie_search_update_url
    assert_response :success
  end

  test "should get destroy" do
    get movie_search_destroy_url
    assert_response :success
  end

end
