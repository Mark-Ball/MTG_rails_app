class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.string :purchase_id
      t.date :purchase_date

      t.timestamps
    end
  end
end
