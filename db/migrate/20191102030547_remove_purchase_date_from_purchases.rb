class RemovePurchaseDateFromPurchases < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :purchase_date, :date
  end
end
