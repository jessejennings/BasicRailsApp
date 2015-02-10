class Post < ActiveRecord::Base
  # t.string   "title"
  # t.text     "body"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.integer  "user_id"
  # t.integer  "topic_id"

  has_many :comments
  belongs_to :user
  belongs_to :topic
  belongs_to :summary

  default_scope { order('created_at DESC') }
end




