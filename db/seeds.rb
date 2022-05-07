# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

names = []
500.times { names << Faker::ElectricalComponents.active }
500.times { names << Faker::ElectricalComponents.passive }
500.times { names << Faker::ElectricalComponents.electromechanical }
names = names.uniq

prices = []
names.count.times { prices << Faker::Number.between(from: 5, to: 500) }

stocks = names.map{ Faker::Number.between(from: 500, to: 10000) }

stocks.count.times { |i| Product.create(name: names[i], price: prices[i], availability: stocks[i], max: stocks[i]) }