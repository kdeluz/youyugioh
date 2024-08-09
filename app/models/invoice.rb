class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :order

  validates :invoice_number, :total, presence: true

  # Method to mark the invoice as paid
  def mark_as_paid
    self.invoice_state = 'paid'
    self.save
  end

  # Method to mark the invoice as shipped
  def mark_as_shipped
    self.invoice_state = 'shipped'
    self.save
  end

  # Method to check if the invoice is paid
  def paid?
    invoice_state == 'paid'
  end

  # Ransackable associations for ActiveAdmin
  def self.ransackable_associations(auth_object = nil)
    ["order", "user"]
  end

  # Ransackable attributes for ActiveAdmin
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "invoice_number", "invoice_state", "order_id", "pst", "qst", "total", "updated_at", "user_id"]
  end
end
