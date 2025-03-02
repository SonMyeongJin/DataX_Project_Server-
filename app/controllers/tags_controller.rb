class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /tags/1
  def show
    render json: {
      id: @tag.id,
      name: @tag.name,
      posts: @tag.posts.select(:id, :title, :content, :user_id, :category_id, :created_at, :updated_at)
    }
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    head :no_content
  end

  private

  # 특정 태그 조회
  def set_tag
    @tag = Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "태그를 찾을 수 없습니다." }, status: :not_found
  end

  # 허용된 파라미터
  def tag_params
    params.require(:tag).permit(:name)
  end
end
