class Topics::PostsController < ApplicationController

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
  end

  def create 
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params) #title: nil, body: nil, user_id: 1, topic_id: nil 
    @post.topic = @topic
      if @post.save
        redirect_to [@topic, @post], notice: "Post saved"
      else
        flash[:error] = "Error saving post"
        render :new
      end
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to [@topic, @post], notice: "Post updated"
    else
      flash[:error] = "Error updating post"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.destroy
    flash[:notice] = "Post was successfully deleted."
    redirect_to @topic
    else
    flash[:error] = "Error deleting post, please try again."
    render :show
    end
  end
   
  private
   
  def post_params
    params.require(:post).permit(:title, :body, :picture, :picture_cache)
  end
   
end
