class CommentsController < ApplicationController
    before_action :set_post
  
    # POST /posts/:post_id/comments
    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user # Assuming you have a current_user method
  
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully added.'
      else
        render 'posts/show', alert: 'Failed to add comment.'
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:comment)
    end
  end
  