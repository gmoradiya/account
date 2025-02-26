class CreateJobInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :job_inventories do |t|
      t.references :job_invoice, null: false
      t.references :product, null: false
      t.decimal :quantity
      t.decimal :remaining_quantity, default: 0.0
      t.decimal :unit_price
      t.decimal :total

      t.timestamps
    end
  end
end
