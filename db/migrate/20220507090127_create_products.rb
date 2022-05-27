class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :symbol
      t.integer :price, null: false
      t.integer :availability, null: false
      t.integer :max, null: false
      t.integer :percent_resource
      t.jsonb :atts
      t.datetime :sent_at

      t.timestamps
    end
  end
end
