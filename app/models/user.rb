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
  mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end
end
