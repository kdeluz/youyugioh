class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_items

  accepts_nested_attributes_for :order_items
end