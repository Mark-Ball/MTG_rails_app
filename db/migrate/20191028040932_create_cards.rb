class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :names, array: true
      t.string :manacost
      t.integer :cmc
      t.string :colors, array: true
      t.string :colorIdentity, array: true
      t.string :card_type
      t.string :supertypes, array: true
      t.string :types, array: true
      t.string :subtypes, array: true
      t.string :rarity
      t.string :set
      t.text :text
      t.string :artist
      t.string :number
      t.integer :power
      t.integer :toughness
      t.string :layout
      t.integer :multiverseid
      t.string :imageUrl
      t.text :rulings, array: true
      t.text :foreignNames, array: true
      t.string :printings
      t.text :originalText
      t.string :originalType
      t.string :magic_card_id

      t.timestamps
    end
  end
end
