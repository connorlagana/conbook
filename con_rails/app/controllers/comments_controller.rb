class PostsController < ApplicationController
  before_action :set_post
  before_action :set_post_post, only: [:show, :update, :destroy]

  # GET /posts/:post_id/posts
  def index
    json_response(@post.posts)
  end

  # GET /posts/:post_id/posts/:id
  def show
    json_response(@post)
  end

  # POST /posts/:post_id/posts
  def create
    @post = @post.posts.create!(post_params)
    # json_response(@post, :created)
    json_response(status: "SUCCESS", message: 'post created successfully.', data: @post.com)

  end

  # PUT /posts/:post_id/posts/:id
  def update
    @post.update(post_params)
    json_response(status: 'SUCCESS', message: 'post updated successfully.', data: @post.com)
  end

  # DELETE /posts/:post_id/posts/:id
  def destroy
    @post.destroy
    json_response(status: 'SUCCESS', message: 'post deleted successfully.', data: @post.com)
  end

  private

  def post_params
    params.permit(:com, :done)
  end

  def set_post
    @post = post.find(params[:post_id])
  end

  def set_post_post
    @post = @post.posts.find_by!(id: params[:id]) if @post
  end
end