class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  def self.purchase_ids
    Purchase.all.map { |i| i.listing_id }
  end
end
