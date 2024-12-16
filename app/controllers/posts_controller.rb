class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user! # Ensure user is logged in for actions requiring authentication

  # GET /posts
  def index
    @posts = Post.all
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
    redirect_to posts_path, alert: 'You cannot edit this post.' unless @post.user == current_user
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
    if @post.user == current_user
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    else
      redirect_to posts_url, alert: 'You cannot delete this post.'
    end
  end

  private

  # Set the post for show, edit, update, and destroy actions
  def set_post
    @post = Post.find_by(id: params[:id])
    if @post.nil? || @post.user != current_user
      redirect_to posts_url, alert: 'Post not found or you are not authorized to access it.'
    end
  end

  # Only allow a list of trusted parameters through
  def post_params
    params.require(:post).permit(:title, :body, :image) # Permit :image parameter
  end
end
