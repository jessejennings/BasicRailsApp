class FavoritesController < ApplicationController
    def create
        @topic = Topic.find(params[:topic_id])
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.build(post: @post)
        if favorite.save
            redirect_to [@topic, @post], notice: "You favor this post"
        else
            flash[:error] = 'Failed to create a favorite.'
            redirect_to [@topic, @post] 
        end
    end
    def destroy
        @topic = Topic.find(params[:topic_id])
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.find(params[:id])
        if favorite.destroy
            redirect_to [@topic, @post], notice: "Favorite deleted"
          
        else
            flash[:error] = 'Failed to  a favorite.'
            redirect_to [@topic, @post] 
        end
    end
end

