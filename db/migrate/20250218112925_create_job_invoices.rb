class CreateJobInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :job_invoices do |t|
      t.string :bill_no
      t.date :date
      t.references :customer, null: false
      t.decimal :total
      t.references :organization

      t.timestamps
    end
  end
end
