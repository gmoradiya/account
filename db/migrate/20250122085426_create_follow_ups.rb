class CreateFollowUps < ActiveRecord::Migration[8.0]
  def change
    create_table :follow_ups do |t|
      t.references :patient, null: false
      t.references :appointment
      t.references :user, null: false

      t.timestamps
    end
  end
end
