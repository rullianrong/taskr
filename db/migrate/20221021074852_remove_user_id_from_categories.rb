class RemoveUserIdFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_reference :categories, :user, index: true
  end
end
