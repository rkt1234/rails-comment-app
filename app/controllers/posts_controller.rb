class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user! # Ensure user is logged in for actions requiring authentication

  # GET /posts
  def index
    # Fetch only posts belonging to the logged-in user
    @posts = current_user.posts
  end

  # GET /posts/:id
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params) # Associate post with logged-in user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  # Set the post for show, edit, update, and destroy actions
  def set_post
    # Ensure the post belongs to the logged-in user to prevent unauthorized access
    @post = current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_url, alert: 'Post not found.'
  end

  # Only allow a list of trusted parameters through
  def post_params
    params.require(:post).permit(:title, :body) # No user_id here
  end
end
