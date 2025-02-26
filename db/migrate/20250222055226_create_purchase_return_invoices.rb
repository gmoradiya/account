class CreatePurchaseReturnInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_return_invoices do |t|
      t.references :organization
      t.references :purchase_invoice
      t.references :supplier, null: false
      t.string :bill_no
      t.date :date
      t.decimal :total
      t.decimal :cgst
      t.decimal :sgst
      t.decimal :discount
      t.decimal :grand_total
      t.decimal :received_amount, default: 0
      t.integer :payment_status, default: 0
      t.text :billing_address
      t.text :delivery_address

      t.timestamps
    end
  end
end
