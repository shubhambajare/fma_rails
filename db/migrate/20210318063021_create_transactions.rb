class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :subcategory_id
      t.string :description
      t.integer :amount
      t.string :img_url

      t.timestamps
    end
    add_index :transactions, :subcategory_id
  end
end
