class AddDailyConsumptionToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :daily_consumption, :integer, default: 0, null: false
    add_column :products, :daily_consumption_ratio, :integer, default: 0, null: false
  end
end
