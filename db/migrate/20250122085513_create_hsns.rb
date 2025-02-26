class CreateHsns < ActiveRecord::Migration[8.0]
  def change
    create_table :hsns do |t|
      t.string :schedule
      t.string :s_no
      t.text :code
      t.string :description
      t.string :chapter_heading
      t.decimal :sgst
      t.decimal :cgst
      t.decimal :gst
      t.decimal :cess
      t.timestamps
    end
  end
end
