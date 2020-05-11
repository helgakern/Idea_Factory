class Like < ApplicationRecord
    belongs_to :user
    belongs_to :idea
  
    # Don't let the same user like the same question more than once.
    validates :idea_id, uniqueness: {
      scope: :user_id,
      message: "Has already been liked"
    }

end