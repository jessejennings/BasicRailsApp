class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to @post, notice: "post successfully created"
    else 
      flash[:error] = "something went wrong!"
      render :new
    end
  end

  def show
  end

  def index
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
