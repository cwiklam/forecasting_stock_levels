class ProductOrder < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  after_save :count_percent_resource
  validates :product_id, presence: true

  scope :oldest, -> { order('created_at ASC') }

  private

  def count_percent_resource
    product.count_percent_resource
  end
end