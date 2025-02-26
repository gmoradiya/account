class AddInvoiceableToSalesInventories < ActiveRecord::Migration[8.0]
  def change
    add_reference :sales_inventories, :invoiceable, polymorphic: true
  end
end
