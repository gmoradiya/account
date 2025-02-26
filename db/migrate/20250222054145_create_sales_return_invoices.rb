class CreateSalesReturnInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :sales_return_invoices do |t|
      t.string :bill_no
      t.references :customer, null: false
      t.date :date
      t.decimal :total
      t.decimal :cgst
      t.decimal :sgst
      t.decimal :discount
      t.decimal :grand_total
      t.decimal :paid_amount, default: 0
      t.integer :payment_status, default: 0
      t.text :billing_address, default: ''
      t.text :delivery_address, default: ''
      t.string :gst_code
      t.integer :bill_type, default: 0
      t.references :organization
      t.references :sales_invoice

      t.timestamps
    end
  end
end
