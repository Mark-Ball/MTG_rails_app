class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :condition
      t.integer :price
      t.references :user, foreign_key: true
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
