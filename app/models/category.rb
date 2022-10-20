class Category < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :user
  has_many :todos
  has_many :tasks, through: :todos
end
