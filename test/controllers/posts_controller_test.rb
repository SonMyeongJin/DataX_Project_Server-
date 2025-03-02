require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: 'New Title', content: 'Some content', category_id: categories(:one).id } }
    end
    assert_response :created # 201 Created 상태 코드를 기대
  end

  test "should update post" do
    patch post_url(@post), params: { post: { title: 'Updated Title', content: 'Updated content' } }
    assert_redirected_to post_path(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_response :no_content
  end
end
