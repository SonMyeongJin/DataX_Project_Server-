class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :update, :destroy]

  # 전체 게시물 조회
  def index
    posts = Post.includes(:user, :category, :tags).order(created_at: :desc)
    render json: posts, include: [:user, :category, :tags]
  end

  # 특정 게시물 조회
  def show
    render json: @post, include: [:user, :category, :tags]
  end

  # 게시물 작성
  def create
    post = current_user.posts.build(post_params.except(:tag_names))
    if post.save
      handle_tags(post, params[:post][:tag_names])
      render json: post, include: [:user, :category, :tags], status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 게시물 수정
  def update
    if @post.user == current_user && @post.update(post_params.except(:tag_names))
      handle_tags(@post, params[:post][:tag_names])
      render json: @post, include: [:user, :category, :tags]
    else
      render json: { error: "수정 권한이 없거나 유효하지 않은 요청입니다." }, status: :unauthorized
    end
  end

  # 게시물 삭제
  def destroy
    if @post.user == current_user
      @post.comments.destroy_all
      @post.tags.destroy_all
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
    params.require(:post).permit(:title, :content, :category_id)
  end

  def handle_tags(post, tag_names)
    return if tag_names.blank?

    tag_ids = tag_names.map do |name|
      Tag.find_or_create_by(name: name).id
    end
    post.tag_ids = tag_ids
  end
end
