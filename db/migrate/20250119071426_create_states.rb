class CreateStates < ActiveRecord::Migration[8.0]
  def change
    create_table :states do |t|
      t.references :country, null: false
      t.string :name
      t.string :code
      t.string :gst_code

      t.timestamps
    end
  end
end
