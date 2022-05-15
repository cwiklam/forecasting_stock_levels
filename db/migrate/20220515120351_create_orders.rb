class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_number, null: false
      t.integer :price, null: false
      t.string :user_id

      t.timestamps
    end
  end
end
