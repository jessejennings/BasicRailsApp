class PostPolicy < ApplicationPolicy

  def index?
    true
  end
end

class Scope < PostPolicy
  
def scope
    record.class
end

end