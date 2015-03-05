class VotesController < 
    before_action :load_post_and_vote
    
    private
    
    def load_post_and_vote
    end
    
    private
    
    def update_vote!(new_value)
        if @vote
            authorize @vote, :update?
            @vote.update_attribute(:value, new_value)
        else
            @vote = current_user.votes.build(value: new_value, post: @post)
            authorize @vote, :create?
            @vote.save
        end
    end
    def up_vote
        
        @post = Post.find(params[:post_id])
        @vote = @post.votes.where(user_id: current_user_id).first
        if @vote
            @vote.update_attribute(:value, 1)
        else
            @vote = current_user.votes.create(value: 1, post: @post)
        end
         # http://apidock.com/rails/ActionController/Base/redirect_to
        redirect_to :back
    end
end

        