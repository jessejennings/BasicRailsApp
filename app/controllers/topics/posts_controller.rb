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
  params.require(:post).permit(:title, :body, :picture, :pictur_cache)
  end
   
end
