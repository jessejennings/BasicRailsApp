class Topic < ActiveRecord::Base
    has_many :posts, dependent: :
    scope :visible_to, -> (user) { user ? all : where(public: true) }
end
