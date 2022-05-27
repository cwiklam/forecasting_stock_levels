every 5.minute do
  runner 'Product.check_stocks'
end

every 1.minute do
  runner 'Product.test'
end