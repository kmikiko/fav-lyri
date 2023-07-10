require "test_helper"

class LyricsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lyrics_index_url
    assert_response :success
  end

  test "should get new" do
    get lyrics_new_url
    assert_response :success
  end

  test "should get edit" do
    get lyrics_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get lyrics_destroy_url
    assert_response :success
  end

  test "should get show" do
    get lyrics_show_url
    assert_response :success
  end
end
