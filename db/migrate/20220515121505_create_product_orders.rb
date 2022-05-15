class CreateProductOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :product_orders do |t|
      t.belongs_to :products
      t.belongs_to :orders
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
