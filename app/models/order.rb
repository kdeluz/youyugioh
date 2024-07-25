class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :address_line1, :city, :province, :postal_code, :country, presence: true
end
