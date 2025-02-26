class CreatePurchaseInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_invoices do |t|
      t.string :bill_no
      t.references :supplier, null: false
      t.date :date
      t.decimal :total
      t.decimal :cgst
      t.decimal :sgst
      t.decimal :discount
      t.integer :payment_status, default: 0
      t.decimal :grand_total
      t.decimal :paid_amount
      t.text :billing_address
      t.text :delivery_address
      t.references :organization

      t.timestamps
    end
  end
end
