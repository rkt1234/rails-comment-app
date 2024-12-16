class Comment < ApplicationRecord
    # Associations
    belongs_to :post
    belongs_to :user
    
    # Validations
    validates :comment, presence: true
    validates :post_id, presence: true
    validates :user_id, presence: true
  
    # Optionally, add any other custom methods or logic if necessary
  end
  