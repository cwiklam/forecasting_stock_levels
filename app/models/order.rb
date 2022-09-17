class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  accepts_nested_attributes_for :product_orders

  scope :newest, -> { order('created_at DESC') }

  validates :order_number, :price, presence: true
  validate :products_count

  before_validation :count_price

  private

  def count_price
    if price.blank?
      self.price = product_orders.sum { |po| po.quantity * po.product.price }
    end
  rescue NoMethodError
    errors.add(:product_orders, "Nie wypełniłeś wszystkich pól")
  end

  def products_count
    product_orders.each do |product_order|
      if product_order.quantity > product_order.product.availability
        product = product_order.product.name
        errors.add("product_order_#{product}", "Niewystarczająca ilość produktu na magazynie")
      end
    end
  end
end