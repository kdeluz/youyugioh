class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :fname
      t.string :card_id
      t.string :konami_id
      t.string :card_type
      t.integer :atk
      t.integer :def
      t.integer :level
      t.string :race
      t.string :card_attribute
      t.string :linkmarker
      t.integer :scale
      t.string :cardset
      t.string :archetype
      t.string :banlist
      t.string :format
      t.boolean :staple
      t.boolean :has_effect
      t.date :startdate
      t.date :enddate
      t.string :dateregion
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2
      t.boolean :sale
      t.timestamps
    end
  end
end
