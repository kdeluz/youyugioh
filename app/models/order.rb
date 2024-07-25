class Order < ApplicationRecord
  belongs_to :user, optional: true

  validates :address_line1, :city, :province, :postal_code, :country, presence: true
end
