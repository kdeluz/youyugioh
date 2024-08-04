class Product < ApplicationRecord
  has_many :cart_items
  has_many :order_items

  validates :name, presence: true
  validates :card_type, presence: true
  validates :price, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[atk banlist card_id card_attribute card_type cardset created_at dateregion def description enddate fname format has_effect id image_url konami_id level linkmarker name price race sale scale startdate staple updated_at archetype]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[cart_items order_items]
  end
end
