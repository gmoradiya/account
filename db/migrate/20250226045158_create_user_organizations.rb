class CreateUserOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :user_organizations do |t|
      t.references :user, null: false
      t.references :organization, null: false

      t.string :role

      t.timestamps
    end
  end
end
