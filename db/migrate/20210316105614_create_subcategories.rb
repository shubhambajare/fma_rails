class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.string :description
      t.integer :category_id
      t.integer :alloted_budget
      t.integer :remaining_budget

      t.timestamps
    end
  end
end
