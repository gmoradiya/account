class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :full_address
      t.string :phone_number
      t.string :gst_detail
      t.string :bank_name
      t.string :account_number
      t.string :ifcs_code
      t.string :branch
      t.string :financial_year, default: ''

      t.timestamps
    end
  end
end
