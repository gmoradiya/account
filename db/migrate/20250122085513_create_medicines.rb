class CreateMedicines < ActiveRecord::Migration[8.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :dosage
      t.text :description

      t.timestamps
    end
  end
end
