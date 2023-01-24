require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should not save category without title" do
    category = Category.new
    assert_not category.save, "Saved the category without a title"
  end
end
