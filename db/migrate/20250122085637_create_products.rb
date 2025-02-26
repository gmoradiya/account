class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :barcode, default: ''
      t.string :description
      t.references :hsn
      t.decimal :price
      t.decimal :quantity, default: 0
      t.references :organization
      t.timestamps
    end
  end
end
