class Post < ApplicationRecord
    # Association with the User model
    belongs_to :user
  
    # Validations (optional but recommended)
    validates :title, presence: true
    validates :body, presence: true
  end
  