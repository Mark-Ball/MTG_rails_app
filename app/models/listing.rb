class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :card
  has_one :purchase
  validates :condition, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 100 }
end
