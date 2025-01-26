class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :patient
      t.datetime :date
      t.string :patient_name
      t.string :phone_number
      t.integer :appointment_type, default: 0, null: false
      t.integer :appointment_status, default: 0, null: false

      t.timestamps
    end
  end
end
