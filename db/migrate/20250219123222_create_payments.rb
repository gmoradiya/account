class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :billable, polymorphic: true, null: false
      t.decimal :amount
      t.date :date
      t.string :payment_detail
      t.integer :payment_mode, default: 0
      t.string :bill_no
      t.references :organization, null: true

      t.timestamps
    end
  end
end
