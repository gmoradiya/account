class CreatePurchaseReturnInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_return_inventories do |t|
      t.references :product
      t.references :purchase_return_invoice
      t.decimal :price, default: 0
      t.decimal :quantity, default: 0
      t.decimal :remaining_quantity, default: 0
      t.decimal :total, default: 0
      t.decimal :cgst_percentage, default: 0
      t.decimal :cgst, default: 0
      t.decimal :sgst_percentage, default: 0
      t.decimal :sgst, default: 0
      t.decimal :discount_percentage, default: 0
      t.decimal :discount, default: 0
      t.decimal :sub_total, default: 0

      t.timestamps
    end
  end
end
