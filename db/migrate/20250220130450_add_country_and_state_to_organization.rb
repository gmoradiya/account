class AddCountryAndStateToOrganization < ActiveRecord::Migration[8.0]
  def change
    add_reference :organizations, :country, null: false
    add_reference :organizations, :state, null: false
  end
end
