class CreateSuppliers < ActiveRecord::Migration[8.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :owner_name
      t.string :phone_number
      t.string :alternate_phone_number
      t.string :email
      t.string :gst_detail
      t.string :pan_number
      t.references :organization

      t.timestamps
    end
  end
end
