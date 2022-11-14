# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(email: 'admin@example.com', password: '123qweASD', confirm_password: '123qweASD')
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
  prices = []
  products.count.times { prices << Faker::Number.between(from: 5, to: 500) }
  stocks = products.map { Faker::Number.between(from: 8000, to: 20000) }

  stocks.count.times { |i| Product.create(name: products[i], price: prices[i], availability: stocks[i], max: stocks[i]) }
  30.times do |i|
    date = DateTime.now - i.days
    products_ids = Product.all.pluck(:id)
    order = Order.new(user_id: user.id, order_number: date.strftime('%Y/%m/%d/%H%M%S%L'))
    product_orders = products_ids.map do |id|
      ProductOrder.new(order: order, product_id: id, quantity: Faker::Number.between(from: 1, to: 1000))
    end.compact
    order.product_orders = product_orders
    next unless order.save
    order.update_columns(created_at: date, updated_at: date)
    order.product_orders.each do |po|
      po.product.update!(availability: po.product.availability - po.quantity)
    end
    product_orders.each do |po|
      po.update_columns(created_at: date, updated_at: date)
    end
  end
end