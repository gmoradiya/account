class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :city
      t.string :pincode
      t.references :state, null: false
      t.references :country, null: false
      t.integer :address_type
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
