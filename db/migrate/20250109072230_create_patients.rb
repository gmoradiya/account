class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.text :address
      t.date :date_of_birth
      t.string :phone_number
      t.string :case_number
      t.string :patient_type
      t.decimal :weight
      t.string :reference_by
      t.string :email
      t.string :occupation
      t.text :chief_complaints
      t.string :sex
      t.date :date_of_signature

      t.timestamps
    end
  end
end
