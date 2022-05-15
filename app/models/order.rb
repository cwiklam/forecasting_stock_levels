class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  accepts_nested_attributes_for :product_orders

  scope :newest, -> { order('created_at DESC') }
end