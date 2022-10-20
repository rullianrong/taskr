class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :body
      t.date :finish_before
      t.boolean :checked
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
