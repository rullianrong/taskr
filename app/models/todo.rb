class Todo < ApplicationRecord
  belongs_to :category
  belongs_to :task

  validates_uniqueness_of :task_id, scope: :category_id
end
