class User < ActiveRecord::Base
  # t.string   "name"
  # t.string   "email",                  default: "", null: false
  # t.string   "encrypted_password",     default: "", null: false
  # t.string   "reset_password_token"
  # t.datetime "reset_password_sent_at"
  # t.datetime "remember_created_at"
  # t.integer  "sign_in_count",          default: 0,  null: false
  # t.datetime "current_sign_in_at"
  # t.datetime "last_sign_in_at"
  # t.string   "current_sign_in_ip"
  # t.string   "last_sign_in_ip"
  # t.datetime "created_at"
  # t.datetime "updated_at"
  # t.string   "confirmation_token"
  # t.datetime "confirmed_at"
  # t.string   "unconfirmed_email"
  # t.datetime "confirmation_sent_at"
  # t.string   "role"
  # t.string   "avatar"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end
  def favorited(post)
    favorites.where(post_id: post.id).first
  end
  def voted(post)
    self.votes.where(post_id: post.id).first
  end
  def self.top_rated
   self.select('users.*') # Select all attributes of the user
       .select('COUNT(DISTINCT comments.id) AS comments_count') # Count the comments made by the user
       .select('COUNT(DISTINCT posts.id) AS posts_count') # Count the posts made by the user
       .select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank') # Add the comment count to the post count and label the sum as "rank"
       .joins(:posts) # Ties the posts table to the users table, via the user_id
       .joins(:comments) # Ties the comments table to the users table, via the user_id
       .group('users.id') # Instructs the database to group the results so that each user will be returned in a distinct row
       .order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query. (rank = comment count + post count)
 end
end
