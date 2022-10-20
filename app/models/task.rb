class Task < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :user
  has_many :todos
  has_many :categories, through: :todos
end
