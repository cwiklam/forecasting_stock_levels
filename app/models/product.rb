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
  after_update :count_weekly_consumption, :count_daily_consumption
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

  def weeks_left
    result       = (resources_left / weekly_consumption)
    ratio        = (weekly_consumption_ratio - 100).abs
    result_ratio = ratio < 20 ? 0 : (ratio < 50 ? 0.1 : 0.2)
    result       = result - result_ratio
    if result < 1
      days_left
    elsif result < 2
      "Mniej niż 2 tygodnie"
    else
      "Powyżej dwóch tygodni"
    end
  end

  def resources_left
    availability
  end

  private

  def days_left
    result       = (resources_left / daily_consumption)
    ratio        = (daily_consumption_ratio - 100).abs
    result_ratio = ratio < 20 ? 0 : (ratio < 50 ? 0.1 : 0.2)
    result       = result - result_ratio
    if result < 1
      "Mniej niż dzień"
    else
      "Ok. #{result.to_i} dni"
    end
  end

  def capitalize_name
    self.name = name.capitalize
  end

  def availability_less_than_max
    return if availability.present? && max.present? && availability <= max

    errors.add(:availability, 'Dostępna ilość produktów jest większa niż maksymalna')
  end

  def count_weekly_consumption
    Product.all.each do |product|
      next if product.orders.count.zero?

      # oldest_date  = Time.parse(product.product_orders.oldest.limit(1).first.created_at.to_s)
      now          = Time.parse(DateTime.now.to_s)
      oldest_date  = now - 42.days
      weeks_count  = (now - oldest_date).seconds.in_weeks.round.abs
      orders_count = product.product_orders.pluck(:quantity).sum # count of all ordered products
      average      = (orders_count / (weeks_count.zero? ? 1 : weeks_count))
      product.update_column(:weekly_consumption, average)
      per_week_count = []
      date           = oldest_date
      weeks_count.times do |i|
        if i == weeks_count
          date2 = now
        else
          date2 = date + 7.days
        end
        per_week_count << product.product_orders.where(:created_at => date..date2).pluck(:quantity).sum
        date = date2
      end
      per_week_count.reject! { |value| value.zero? }
      ratio = per_week_count.map do |value|
        (average * 100) / value
      end.sum / per_week_count.count
      product.update_column(:weekly_consumption_ratio, ratio)
    end
  end

  def count_daily_consumption
    Product.all.each do |product|
      next if product.orders.count.zero?

      # oldest_date  = Time.parse(product.product_orders.oldest.limit(1).first.created_at.to_s)
      now          = Time.parse(DateTime.now.to_s)
      oldest_date  = now - 42.days
      days_count   = (now - oldest_date).seconds.in_days.round.abs
      orders_count = product.product_orders.pluck(:quantity).sum
      average      = (orders_count / (days_count.zero? ? 1 : days_count))
      product.update_column(:daily_consumption, average)
      per_day_count = []
      date          = oldest_date
      days_count.times do |i|
        if i == days_count
          date2 = now
        else
          date2 = date + 1.days
        end
        per_day_count << product.product_orders.where(:created_at => date..date2).pluck(:quantity).sum
        date = date2
      end
      per_day_count.reject! { |value| value.zero? }
      ratio = per_day_count.map do |value|
        (average * 100) / value
      end.sum / per_day_count.count
      product.update_column(:daily_consumption_ratio, ratio)
    end
  end
end