class CreatePrescriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :prescriptions do |t|
      t.references :appointment, null: false
      t.references :follow_up, null: false
      t.references :medicine, null: false
      t.string :dosage
      t.string :note

      t.timestamps
    end
  end
end
