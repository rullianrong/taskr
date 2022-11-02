class Todo < ApplicationRecord
  belongs_to :category
  belongs_to :task

  # validation to avoid duplicate in the join table
  validates_uniqueness_of :task_id, scope: :category_id
end
