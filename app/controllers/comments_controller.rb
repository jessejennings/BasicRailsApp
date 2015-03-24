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
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize @comment
    if @comment.destroy
     flash[:notice] = "Comment was removed."
    else
     flash[:error] = "Comment couldn't be deleted. Try again."
    end

    respond_to do |format|
      format.html
      format.js
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
