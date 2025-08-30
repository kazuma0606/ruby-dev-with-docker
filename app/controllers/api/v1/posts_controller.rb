class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  
  # GET /api/v1/posts
  def index
    @posts = Post.includes(:user).all
    render json: @posts.as_json(include: :user)
  end
  
  # GET /api/v1/posts/:id
  def show
    render json: @post.as_json(include: :user)
  end
  
  # POST /api/v1/posts
  def create
    @post = Post.new(post_params)
    
    if @post.save
      render json: @post.as_json(include: :user), status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end
  
  # PUT /api/v1/posts/:id
  def update
    if @post.update(post_params)
      render json: @post.as_json(include: :user)
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/v1/posts/:id
  def destroy
    @post.destroy
    head :no_content
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end
  
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end