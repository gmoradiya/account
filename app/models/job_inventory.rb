class JobInventory < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :job_invoice
  belongs_to :product

  has_many :sales_inventories, as: :invoiceable

  after_create :update_product_stock

  private

  def update_product_stock
    product.update(quantity: product.quantity + quantity)
  end
end
