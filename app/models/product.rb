class Product < ApplicationRecord
  scope :newest, -> { order('created_at DESC') }
end