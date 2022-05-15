class Product < ApplicationRecord
  has_many :product_orders, dependent: :nullify
  has_many :orders, through: :product_orders

  scope :newest, -> { order('created_at DESC') }
end