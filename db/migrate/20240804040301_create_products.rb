class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :fname
      t.integer :card_id
      t.integer :konami_id
      t.string :card_type
      t.integer :atk
      t.integer :def
      t.integer :level
      t.string :race
      t.string :card_attribute
      t.string :linkmarker
      t.string :scale
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
      t.decimal :price, precision: 10, scale: 2
      t.boolean :sale
      t.timestamps
    end

    add_reference :products, :image, foreign_key: { to_table: :active_storage_attachments }
  end
end
