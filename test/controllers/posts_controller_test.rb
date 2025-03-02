require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one) # 예시로 @post 픽스처 설정
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: 'New Title', content: 'Some content', category_id: categories(:one).id } }
    end
    assert_redirected_to post_url(Post.last) # 생성 후 해당 포스트의 상세 페이지로 리다이렉트되는지 확인
  end

  test "should update post" do
    patch post_url(@post), params: { post: { title: 'Updated Title', content: 'Updated content' } }
    assert_redirected_to post_url(@post) # 업데이트 후 해당 포스트의 상세 페이지로 리다이렉트되는지 확인
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url # 삭제 후 포스트 목록 페이지로 리다이렉트되는지 확인
  end
end
