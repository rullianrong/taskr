class Category < ApplicationRecord
  has_many :todos, dependent: :destroy
  has_many :tasks, through: :todos

  before_save :capitalize_attributes

  private
  def capitalize_attributes
    self.title = title.titleize 
  end
end
