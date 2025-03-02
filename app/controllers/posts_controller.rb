class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # 로그인 필요
  before_action :set_post, only: [:show, :update, :destroy]

  # 전체 게시물 조회
  def index
    posts = Post.includes(:user, :category).order(created_at: :desc)
    render json: posts, include: [:user, :category]
  end

  # 특정 게시물 조회
  def show
    render json: @post, include: [:user, :category]
  end

  # 게시물 작성
  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 게시물 수정
  def update
   if @post.user == current_user && @post.update(post_params)
     redirect_to @post # 수정 성공 시 게시물로 리디렉트
   else
     render json: { error: "수정 권한이 없거나 유효하지 않은 요청입니다." }, status: :unauthorized
   end
 end

  # 게시물 삭제
  def destroy
    if @post.user == current_user
      @post.comments.destroy_all # 모든 관련된 댓글 삭제
      @post.destroy
      head :no_content
    else
      render json: { error: "삭제 권한이 없습니다." }, status: :unauthorized
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "게시물을 찾을 수 없습니다." }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, tag_ids: [])
  end
end
