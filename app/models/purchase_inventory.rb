class PurchaseInventory < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :product
  belongs_to :purchase_invoice

  has_many :sales_inventories, as: :invoiceable

  after_create :update_product_stock
  after_create :update_data

  private

  def update_product_stock
    product.update(quantity: product.quantity + quantity)
  end

  def update_data
    total = price * quantity
    cgst = total * cgst_percentage / 100.0
    sgst = total * sgst_percentage / 100.0
    discount = (total + sgst + cgst) * discount_percentage / 100.0
    sub_total = total + sgst + cgst - discount
    update(total: total, cgst: cgst, sgst: sgst, discount: discount, sub_total: sub_total, remaining_quantity: quantity)
  end
end
