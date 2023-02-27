# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user               = User.create(email: 'admin@example.com', password: '123qweASD', confirm_password: '123qweASD')
electronical_parts = false
if electronical_parts
  names = []
  500.times { names << Faker::ElectricalComponents.active }
  500.times { names << Faker::ElectricalComponents.passive }
  500.times { names << Faker::ElectricalComponents.electromechanical }
  names = names.uniq

  prices = []
  names.count.times { prices << Faker::Number.between(from: 5, to: 500) }

  stocks = names.map { Faker::Number.between(from: 500, to: 10000) }

  stocks.count.times { |i| Product.create(name: names[i], price: prices[i], availability: stocks[i], max: stocks[i]) }
end

unless electronical_parts
  products = %w[Telewizor Laptop Komputer Smartfon Pralka Lodówka Mikrofala Express Toster Kuchenka]
  prices   = []
  products.count.times { prices << Faker::Number.between(from: 5, to: 500) }
  stocks = products.map { Faker::Number.between(from: 16000, to: 20000) }

  n    = 0
  week = 0
  l1   = Faker::Number.between(from: 0, to: 9)
  l2   = Faker::Number.between(from: 0, to: 9)
  if (l1 == l2 && l2 < 9)
    l2 = l2 + 1
  elsif (l1 == l2 && l2 < 9)
    l2 = l2 - 1
  end

  stocks.count.times { |i| Product.create(name: products[i], price: prices[i], availability: stocks[i], max: stocks[i]) }
  42.times do |i|
    week                 += 1 if i % 7 == 0
    n                    += 60 if i % 5 == 0
    date                 = DateTime.now - i.days
    products             = Product.all
    order                = Order.new(user_id: user.id, order_number: date.strftime('%Y/%m/%d/%H%M%S%L'))
    product_orders       = products.map do |product|
      product.update_columns(availability: product.availability + Faker::Number.between(from: 1500, to: 5000)) if (product.availability < 3000)
      if product.id == l1
        ProductOrder.new(order: order, product_id: product.id, quantity: (i % 2 == 0 ? Faker::Number.between(from: 150, to: 500) : Faker::Number.between(from: 900, to: 1400)))
      elsif product.id == l2
        ProductOrder.new(order: order, product_id: product.id, quantity: (week % 2 == 0 ? Faker::Number.between(from: 150, to: 500) : Faker::Number.between(from: 900, to: 1400)))
      else
        ProductOrder.new(order: order, product_id: product.id, quantity: Faker::Number.between(from: 5, to: 1000) + n + ((Faker::Boolean.boolean(true_ratio: 0.3)) ? Faker::Number.between(from: 200, to: 500) : 0))
      end
    end.compact
    order.product_orders = product_orders
    order.save!
    order.update_columns(created_at: date, updated_at: date)
    order.product_orders.each do |po|
      po.product.update_columns(availability: po.product.availability - po.quantity)
    end
    product_orders.each do |po|
      po.update_columns(created_at: date, updated_at: date)
    end
  end
  product = Product.first
  product.update(symbol: product.symbol)
end