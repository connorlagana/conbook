class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = current_user.posts
    json_response(@posts)
  end

  # POST /posts
  def create
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  # GET /posts/:id
  def show
    json_response(@post)
  end

  def index
    # get current user posts
    @posts = current_user.posts
    json_response(@posts)
  end
  # [...]
  # POST /posts
  def create
    # create posts belonging to current user
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end
  # [...]
  private

  # remove `created_by` from list of permitted parameters
  def post_params
    params.permit(:description)
  end

  # PUT /posts/:id
  def update
    @post.update(post_params)
    json_response(status: 'SUCCESS', message: 'updated the post', data: @post.description)
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    json_response(status: 'SUCCESS', message: 'deleted the post', data: @post.description)

  end

  private

  def post_params
    # whitelist params
    params.permit(:description)
  end

  def set_post
    @post = post.find(params[:id])
  end
end