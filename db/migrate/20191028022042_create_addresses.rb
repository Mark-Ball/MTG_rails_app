class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :suburb
      t.string :city
      t.string :country
      t.string :postcode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
