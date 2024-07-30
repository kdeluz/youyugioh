class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :order

  validates :invoice_number, :total, presence: true
end
