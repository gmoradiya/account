class SalesInventory < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :invoiceable, polymorphic: true, optional: true
  belongs_to :sales_invoice
  belongs_to :product

  after_create :update_stock
  after_update :manage_stock

  after_save :update_data

  validate :custom_invoiceable_presence
  validate :quantity_check

  def quantity_check
    # if quantity > invoiceable.quantity
    #   errors.add(:base, "Quantity is greater than available quantity.")
    # end
  end

  def custom_invoiceable_presence
    if invoiceable.nil?
      # errors.add(:base, "Invoice link (Chalan) is required. for adjust quantity")
    end
  end

  def update_stock
    product.update(quantity: product.quantity - quantity)
  end

  def manage_stock
    if quantity_changed?
      quantity_change = quantity_before_last_save - quantity
      product.update(quantity: product.quantity - quantity_change)
    end
  end

  def update_data
    if saved_change_to_price? || saved_change_to_quantity? ||saved_change_to_cgst_percentage? || saved_change_to_sgst_percentage? ||  saved_change_to_discount_percentage? || saved_change_to_id?
      total = price * quantity
      cgst = total * cgst_percentage / 100.0
      sgst = total * sgst_percentage / 100.0
      discount = (total + sgst + cgst) * discount_percentage / 100.0
      sub_total = total + sgst + cgst - discount
      update(total: total, cgst: cgst, sgst: sgst, discount: discount, sub_total: sub_total)
    end
  end
end
