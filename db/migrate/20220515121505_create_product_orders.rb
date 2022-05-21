class CreateProductOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :product_orders do |t|
      t.belongs_to :product
      t.belongs_to :order
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
