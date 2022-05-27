class Product < ApplicationRecord
  has_many :product_orders, dependent: :nullify
  has_many :orders, through: :product_orders

  scope :newest, -> { order('created_at DESC') }
  scope :smallest_resources, -> { order('percent_resource ASC').limit(15) }
  scope :low_resources, -> { where('percent_resource <= 20') }

  validate :availability_less_than_max

  after_save :count_percent_resource

  def count_percent_resource
    update_column(:percent_resource, (availability * 100 / max * 100) / 100)
  end

  def self.check_stocks
    products = Product.low_resources
    products.each do |product|
      next if product.sent_at.present? && ((DateTime.now.mjd - product.sent_at.mjd) < 1)

      SendSms.new(product: product).call
      product.update_column(:sent_at, DateTime.now)
    end
  end

  def self.test
    Log.create(txt: 'CRON')
  end

  private

  def availability_less_than_max
    return if availability <= max

    errors.add(:availability, 'Dostępna ilość produktów jest większa niż maksymalna')
  end
end