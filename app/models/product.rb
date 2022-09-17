class Product < ApplicationRecord
  has_many :product_orders, dependent: :nullify
  has_many :orders, through: :product_orders

  scope :newest, -> { order('created_at DESC') }
  scope :alphabetically, -> { order(:name) }
  scope :smallest_resources, -> { order('percent_resource ASC').limit(15) }
  scope :low_resources, -> { where('percent_resource <= 20') }

  validates :name, :price, :availability, :max, presence: true
  validates :price, :availability, :max, numericality:
    { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100000 }
  validate :availability_less_than_max

  after_save :count_percent_resource
  before_save :capitalize_name

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

  def capitalize_name
    self.name = name.capitalize
  end

  def availability_less_than_max
    return if availability.present? && max.present? && availability <= max

    errors.add(:availability, 'Dostępna ilość produktów jest większa niż maksymalna')
  end
end