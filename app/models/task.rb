class Task < ApplicationRecord
  validates :body, presence: { message: "of the task can't be blank" }

  belongs_to :user
  has_many :todos, dependent: :destroy
  has_many :categories, through: :todos
end
