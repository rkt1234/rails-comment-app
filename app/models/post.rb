class Post < ApplicationRecord
    # Association with the User model
    has_many :comments, dependent: :destroy # Make sure to add this line
    belongs_to :user
    mount_uploader :image, ImageUploader

  
    # Validations (optional but recommended)
    validates :title, presence: true
    validates :body, presence: true
  end
  