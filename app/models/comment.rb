class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, length: {minimum: 5}, presence: true
  default_scope { order('updated_at DESC') }
  
  after_create :send_favorite_emails
  
  private
  
  def send_favorite_emails
    if post.user_id != self.user_id && post.user.email_favorites?
      FavoriteMailer.new_comment(post.user, self.post, self).deliver
    end
  end
end
